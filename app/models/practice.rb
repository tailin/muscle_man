class Practice < ApplicationRecord
  # validates_numericality_of :games_played, :only_integer => true
  BAR_LIST = ["槓鈴", "啞鈴", "W槓", "機械式", "Cable", "徒手"]
  BODY_TYPE = ["胸", "背","腿","肩膀","手臂","核心"]
  MOVING_LIST={
    "胸":["上胸", "平胸", "下胸", "夾胸"],
    "背":["硬舉", "站立划船", "坐式划船", "滑輪下拉", "單槓"], 
    "腿":["深蹲", "羅馬尼亞", "股四頭抬腿", "股二頭夾腿", "內夾腿","外夾腿", "小腿蹬"],
    "肩膀":["肩推", "側飛鳥", "Face pull"], 
    "手臂":["二頭彎舉","錘式","繩索三頭", "三頭"],
    "核心": ["抬腿"]
  }
end
