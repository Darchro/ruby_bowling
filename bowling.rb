class Bowling

  attr_accessor :frames, :bonus

  def initialize(rolls)
    self.frames = rolls
    self.bonus = rolls.last if rolls.count == 11
  end

  def strike?(frame)
    frame.nil? ? false : frame[0] == 10
  end

  def sum_frame(frame)
    frame.nil?  ? 0 : frame.inject(:+)
  end

  def spare?(frame)
    frame.nil? ? false : !strike?(frame) && sum_frame(frame) == 10
  end

  def score
    score = 0
    frames.each_with_index do |frame, ind|
      score += sum_frame(frame) if !strike?(frame) && !spare?(frame) && frame  != self.bonus
      score += score_strike(frame, ind) if strike?(frame) && frame  != self.bonus
      score += score_spare(frame, ind) if spare?(frame) && frame  != self.bonus
    end
    score
  end

  private

  def score_strike(frame, ind)
    if strike?(frames[ind+1])  && frames[ind+1] != self.bonus
      frame[0] + frames[ind+1][0] + frames[ind+2][0]
    else
      frame[0] + sum_frame(frames[ind+1])
    end
  end

  def score_spare(frame, ind)
     frames[ind+1] ? sum_frame(frame) + frames[ind+1][0] : sum_frame(frame)
  end

end