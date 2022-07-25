
import RealityKit
import Foundation
import ARKit


enum FlipTableError: Error {
  case unevenDimensions
  case dimensionsTooLarge
}

/// FlipTable class contains all the cards in the game
class FlipTable: Entity, HasAnchoring, HasCollision {
    // 利用できる色の配列
  static var availableColors: [UIColor] = [
    .red,
    .orange,
    .yellow,
    .green,
    .blue,
    .purple,
    .brown,
    .systemCyan,
  ]
  /// After 2 non matching cards are flipped, they will flip back to non-reveal state after this time in seconds
  var flipBackTimeout = 0.5
  let dimensions: SIMD2<Int>
  var minimumBounds: SIMD2<Float>? = nil {
    didSet {
        
      guard let bounds = minimumBounds else {
        return
      }
      let anchorPlane = AnchoringComponent.Target.plane(
          .horizontal,
          classification: .any,
          minimumBounds: bounds)
        let anchorComponent = AnchoringComponent(anchorPlane)

      self.anchoring = anchorComponent

      let maxDim = dimensions.max()
      let minBound = bounds.min()
      self.scale = SIMD3<Float>(repeating: minBound / Float(maxDim))
    }
  }

  /// Create a new FlipTable Entity
  /// - Parameter dimensions: How many cards across and deep do you want the game to be
  init(dimensions: SIMD2<Int>) throws {
      // Cardcomponentをcomponentとして追加する
    CardComponent.self.registerComponent()
    self.dimensions = dimensions
      // カードの数
    let cardCount = dimensions[0] * dimensions[1]
      //カードの数が2で割り切れなかったらエラーを投げる
    if (cardCount % 2) == 1 {
      throw FlipTableError.unevenDimensions
        // 色の数と相違があったらエラーを投げる。
    } else if (cardCount) > (FlipTable.availableColors.count * 2) {
      throw FlipTableError.dimensionsTooLarge
    }
    super.init()
      // カードの色の配列
    let colorsToUse = FlipTable.availableColors[0...((cardCount - 1) / 2)]
      print(colorsToUse, "ColorsToUse配列")
      // 全てのIDの配列
    let allIDs = Array(0..<cardCount).map { $0 / 2 }.shuffled()
      print(allIDs, "allIds！！！")
    for row in 0..<dimensions[0] {
      for col in 0..<dimensions[1] {
        let positionIndex = row * dimensions[0] + col
          print("postionIndex")
        let colorIndex = allIDs[positionIndex]
        let newCard = FlipCard(color: colorsToUse[colorIndex], id: colorIndex)
          print(newCard,"カードを作るよ！")
          // カードの大きさを指定
        newCard.scale = [0.9, 0.9, 0.9]
          // カードのpositionをdimensionsを使って指定。
        newCard.position = [
          Float(col) - Float(dimensions[1] - 1) / 2,
          0,
          Float(row) - Float(dimensions[0] - 1) / 2
        ]
        self.addChild(newCard)
      }
    }
  }

  required init() {
    fatalError("FlipTable requires a size in initializer")
  }
}
