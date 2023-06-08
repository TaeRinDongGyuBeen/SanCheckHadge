//
//  PointModel.swift
//  InToTheSeoul
//
//  Created by 정승균 on 2023/06/04.
//

import Foundation
import CoreLocation

final class PointsModel: ObservableObject {
    @Published var points: [Point] = jsonLoader("Points.json")
    @Published var selectedPoints: [ViewPoint] = []
    @Published var annotationPoints: [AnnotationPoint] = []
    var mustWaypointNumber: [Int] = []
    
    func recommendPoint(nowPostion: CLLocationCoordinate2D, walkTimeMin: Int, mustWaypoint: Waypoint) throws -> Void {
        var selectedPoints: [Point] = []
        var resultPoints: [ViewPoint] = []
        var pointsDistance: [Double] = []
        var waypoint: Waypoint = mustWaypoint
        
        // 입력된 시간을 거리로 환산 (if 10분 : 3km/h * 10/60h -> 0.5km -> 500m) => remained walking distance(purposeWalkDistance)
        let purposeWalkingDistance: Double = 3000 * (Double(walkTimeMin)/60)
        var remainedWalkingDistance: Double = purposeWalkingDistance
        
        print("======> purposeWalkingDistance \(purposeWalkingDistance)")
        print("======> remainedWalingDistance \(remainedWalkingDistance)")
        
        // 내 위치 불러오기
        // 내 위치 반경 purpose에 있는 모든 포인트 검색
        let candidatePoints: [Point] = points.filter {
            $0.locationCoordinate.distance(from: nowPostion) <= purposeWalkingDistance
        }
        
        if candidatePoints.isEmpty {
            throw RecommendError.pointNotFound
        }
        
        print("======> candidatePoint Count \(candidatePoints.count)")
        
        // 선택된 포인트 중 반경 50m 내의 포인트 하나를 랜덤으로 선택
        do {
            try selectedPoints.append(selectFirstPoint(candidatePoints, nowPosition: nowPostion))
        } catch {
            print(error.localizedDescription)
            return
        }
        
        // 첫 번째 지점 거리 입력
        pointsDistance.append((selectedPoints.first?.locationCoordinate.distance(from: nowPostion))!)
        
        print("======> selectedPoint \(selectedPoints)")

        // 현재 위치에서 선택된 포인트로의 방향 및 거리를 계산
        let firstDirection = decideForwardDirection(nowPosition: nowPostion, firstPoint: selectedPoints[0].locationCoordinate)
        var forwardDirection = firstDirection
        print("======> 현 위치 : \(nowPostion.latitude) \(nowPostion.longitude) 첫 포인트 위치 : \(selectedPoints[0].locationCoordinate.latitude) \(selectedPoints[0].locationCoordinate.longitude)")
        print("======> 방향 \(forwardDirection)")
        
        // remained walking distance = remained walking distance - point distance (걸어야 할 거리 - 다음 지점까지 거리) 계산
        // 다음 지점 까지의 거리는 CLLocation.distance(from:) 함수 사용
        // (purpose distance * 0.3) <= to walk distance 될 때까지 다음 경로 계속 추천
        remainedWalkingDistance -= selectedPoints[0].locationCoordinate.distance(from: nowPostion)
        print("남은거리 : \(remainedWalkingDistance)")
        do {
            remainedWalkingDistance = try selectForwardPoint(remainedDistance: remainedWalkingDistance, purposeDistance: purposeWalkingDistance, candidatePoints: candidatePoints, direction: forwardDirection, stepCount: .first, mustWaypoint: &waypoint, selectedPoints: &selectedPoints, nextDistance: &pointsDistance)
        } catch {
            print(error.localizedDescription)
            return
        }
        
        // if (purpose distance * 0.3) <= to walk distance 방향 전환
        forwardDirection = changeDirection(nowDirection: forwardDirection)
        print("======> 전환된 방향 \(forwardDirection)")
        
        // 30% 전진
        do {
            remainedWalkingDistance = try selectForwardPoint(remainedDistance: remainedWalkingDistance, purposeDistance: purposeWalkingDistance, candidatePoints: candidatePoints, direction: forwardDirection, stepCount: .second, mustWaypoint: &waypoint, selectedPoints: &selectedPoints, nextDistance: &pointsDistance)
        } catch {
            print(error.localizedDescription)
            return
        }
        print(remainedWalkingDistance)
        
        // Come Back Home ~
        // 돌아가는 방향 정의
        forwardDirection = backHomeDirection(firstDirection: firstDirection, nowDirection: forwardDirection)
        print("======> 마지막 전환된 방향 \(forwardDirection)")
        
        // 남은 거리 Back
        do {
            remainedWalkingDistance = try selectForwardPoint(remainedDistance: remainedWalkingDistance, purposeDistance: purposeWalkingDistance, candidatePoints: candidatePoints, direction: forwardDirection, stepCount: .last, mustWaypoint: &waypoint, selectedPoints: &selectedPoints, nextDistance: &pointsDistance)
        } catch {
            print(error.localizedDescription)
            return
        }
        
        print("=====> 마지막 지점과 집까지의 거리 \(selectedPoints.last?.locationCoordinate.distance(from: nowPostion))")
        
        print(selectedPoints.count)
        print(pointsDistance.count)
        
        // 집으로 Back
        let homePoint: Point = Point(name: "출발지점", lat: String(nowPostion.latitude), lon: String(nowPostion.longitude), category: "출발지점", address: "출발지점", id: 999999999)
        pointsDistance.append(homePoint.locationCoordinate.distance(from: (selectedPoints.last?.locationCoordinate)!))
        selectedPoints.append(homePoint)
        
        for selectedPoint in selectedPoints.enumerated() {
            if !mustWaypointNumber.isEmpty && selectedPoint.offset == mustWaypointNumber[0] {
                resultPoints.append(ViewPoint(id: selectedPoint.offset, mustWaypoint: true, distanceNextPoint: pointsDistance[selectedPoint.offset], nowPoint: selectedPoint.element))
                print(ViewPoint(id: selectedPoint.offset, mustWaypoint: true, nowPoint: selectedPoint.element))
                mustWaypointNumber.removeFirst()
            } else {
                resultPoints.append(ViewPoint(id: selectedPoint.offset, distanceNextPoint: pointsDistance[selectedPoint.offset], nowPoint: selectedPoint.element))
            }
        }
        
        resultPoints[resultPoints.count - 1].isStartPoint = true
        
        self.selectedPoints = resultPoints
        
        for point in self.selectedPoints {
            annotationPoints.append(AnnotationPoint(viewPoint: point))
        }
    }
    
    private func selectFirstPoint(_ candidatePoints: [Point], nowPosition: CLLocationCoordinate2D) throws -> Point {
        var firstCandidatePoints: [Point] = []
        var searchDistance: Double = 50.0
        
        while firstCandidatePoints.isEmpty {
            firstCandidatePoints = candidatePoints.filter {
                $0.locationCoordinate.distance(from: nowPosition) <= searchDistance
            }
            
            searchDistance += 50.0
        }
        
        print("=====> firstCandidatePoints \(firstCandidatePoints)")
        for firstCandidatePoint in firstCandidatePoints {
            print(firstCandidatePoint.locationCoordinate.distance(from: nowPosition))
        }
        guard let firstPoint = firstCandidatePoints.randomElement() else {
            throw RecommendError.pointNotFound
        }
        
        return firstPoint
    }
    
    private func selectForwardPoint(remainedDistance: Double, purposeDistance: Double, candidatePoints: [Point], direction: ForwardDirection, stepCount: DirectionCount, mustWaypoint: inout Waypoint, selectedPoints: inout [Point], nextDistance: inout [Double]) throws -> Double {
        var calculatedDistance = remainedDistance
        var searchRange: Double = 100.0
        let purposeRatio: Double = stepCount.rawValue
        var i: Int = selectedPoints.count - 1
        
        while (purposeDistance * purposeRatio) < calculatedDistance {
            // 이전에 나왔던 카테고리는 웬만하면 지양
            let selectedPointLocation: CLLocationCoordinate2D = selectedPoints[i].locationCoordinate
            var nextCandidatePoints: [Point] = []
            
            switch direction {
            case .NE:
                nextCandidatePoints = candidatePoints.filter {
                    $0.locationCoordinate.latitude > selectedPointLocation.latitude &&
                    $0.locationCoordinate.longitude > selectedPointLocation.longitude &&
                    $0.locationCoordinate.distance(from: selectedPointLocation) <= searchRange &&
                    $0.locationCoordinate.distance(from: selectedPointLocation) >= 100.0
                }
            case .NW:
                nextCandidatePoints = candidatePoints.filter {
                    $0.locationCoordinate.latitude > selectedPointLocation.latitude &&
                    $0.locationCoordinate.longitude < selectedPointLocation.longitude &&
                    $0.locationCoordinate.distance(from: selectedPointLocation) <= searchRange &&
                    $0.locationCoordinate.distance(from: selectedPointLocation) >= 100.0
                }
            case .SW:
                nextCandidatePoints = candidatePoints.filter {
                    $0.locationCoordinate.latitude < selectedPointLocation.latitude &&
                    $0.locationCoordinate.longitude < selectedPointLocation.longitude &&
                    $0.locationCoordinate.distance(from: selectedPointLocation) <= searchRange &&
                    $0.locationCoordinate.distance(from: selectedPointLocation) >= 100.0
                }
            case .SE:
                nextCandidatePoints = candidatePoints.filter {
                    $0.locationCoordinate.latitude < selectedPointLocation.latitude &&
                    $0.locationCoordinate.longitude > selectedPointLocation.longitude &&
                    $0.locationCoordinate.distance(from: selectedPointLocation) <= searchRange &&
                    $0.locationCoordinate.distance(from: selectedPointLocation) >= 100.0
                }
            }
            
            print("======> 다음 후보 리스트 \(nextCandidatePoints.count)")
            
            // 150m내 포인트가 없을 시 검색 범위를 50m 늘림
            if nextCandidatePoints.isEmpty {
                searchRange += 50.0
                continue
            }
            
            if mustWaypoint.hospital && !(nextCandidatePoints.filter { $0.category == "Hospital" }.isEmpty) {
                mustWaypoint.hospital = false
                let selectedWayPoint: Point = nextCandidatePoints.filter { $0.category == "Hospital" }.first!
                selectedPoints.append(selectedWayPoint)
                nextDistance.append(selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation))
                calculatedDistance -= selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation)
                searchRange = 50.0
                i += 1
                self.mustWaypointNumber.append(i)
                continue
            } else if mustWaypoint.library && !(nextCandidatePoints.filter { $0.category == "Library" }.isEmpty) {
                mustWaypoint.library = false
                let selectedWayPoint: Point = nextCandidatePoints.filter { $0.category == "Library" }.first!
                selectedPoints.append(selectedWayPoint)
                nextDistance.append(selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation))
                calculatedDistance -= selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation)
                searchRange = 50.0
                i += 1
                self.mustWaypointNumber.append(i)
                continue
            } else if mustWaypoint.park && !(nextCandidatePoints.filter { $0.category == "Park" }.isEmpty) {
                mustWaypoint.park = false
                let selectedWayPoint: Point = nextCandidatePoints.filter { $0.category == "Park" }.first!
                selectedPoints.append(selectedWayPoint)
                nextDistance.append(selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation))
                calculatedDistance -= selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation)
                searchRange = 50.0
                i += 1
                self.mustWaypointNumber.append(i)
                continue
            } else if mustWaypoint.pharmacy && !(nextCandidatePoints.filter { $0.category == "Pharmacy" }.isEmpty) {
                mustWaypoint.pharmacy = false
                let selectedWayPoint: Point = nextCandidatePoints.filter { $0.category == "Pharmacy" }.first!
                selectedPoints.append(selectedWayPoint)
                nextDistance.append(selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation))
                calculatedDistance -= selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation)
                searchRange = 50.0
                i += 1
                self.mustWaypointNumber.append(i)
                continue
            } else if mustWaypoint.busStop && !(nextCandidatePoints.filter { $0.category == "Bus" }.isEmpty) {
                mustWaypoint.busStop = false
                let selectedWayPoint: Point = nextCandidatePoints.filter { $0.category == "Bus" }.first!
                selectedPoints.append(selectedWayPoint)
                nextDistance.append(selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation))
                calculatedDistance -= selectedWayPoint.locationCoordinate.distance(from: selectedPointLocation)
                searchRange = 50.0
                i += 1
                self.mustWaypointNumber.append(i)
                continue
            }
            
            guard let nextPoint = nextCandidatePoints.randomElement() else {
                throw RecommendError.pointNotFound
            }
            
            selectedPoints.append(nextPoint)
            print("=====> 현재 개수 : \(selectedPoints.count) 값 : \(selectedPoints)")
            nextDistance.append(nextPoint.locationCoordinate.distance(from: selectedPointLocation))
            calculatedDistance -= nextPoint.locationCoordinate.distance(from: selectedPointLocation)
            print("=====> 남은 거리 : \(calculatedDistance)")
            
            searchRange = 50.0
            i += 1
        }
        print("=====> 남은 거리 : \(calculatedDistance)")
        return calculatedDistance
    }
}

extension PointsModel {
    private func decideForwardDirection(nowPosition: CLLocationCoordinate2D, firstPoint: CLLocationCoordinate2D) -> ForwardDirection {
        if firstPoint.latitude > nowPosition.latitude && firstPoint.longitude > nowPosition.longitude {
            return .NE
        } else if firstPoint.latitude > nowPosition.latitude && firstPoint.longitude < nowPosition.longitude {
            return .NW
        } else if firstPoint.latitude < nowPosition.latitude && firstPoint.longitude < nowPosition.longitude {
            return .SW
        } else {
            return .SE
        }
    }
    
    
    private func changeDirection(nowDirection: ForwardDirection) -> ForwardDirection {
        var candidateDirections: [ForwardDirection]
        
        switch nowDirection {
        case .NE:
            candidateDirections = [.NW, .SE]
            return candidateDirections.randomElement() ?? .NW
        case .NW:
            candidateDirections = [.NE, .SW]
            return candidateDirections.randomElement() ?? .NE
        case .SW:
            candidateDirections = [.NW, .SE]
            return candidateDirections.randomElement() ?? .SE
        case .SE:
            candidateDirections = [.SW, .NE]
            return candidateDirections.randomElement() ?? .SW
        }
    }
    
    private func backHomeDirection(firstDirection: ForwardDirection, nowDirection: ForwardDirection) -> ForwardDirection {
        switch nowDirection {
        case .NE:
            if firstDirection == .NW {
                return .SE
            } else {
                return .NW
            }
        case .NW:
            if firstDirection == .NE {
                return .SW
            } else {
                return .NE
            }
        case .SW:
            if firstDirection == .NW {
                return .SE
            } else {
                return .NW
            }
        case .SE:
            if firstDirection == .SW {
                return .NE
            } else {
                return .SW
            }
        }
    }
}


