require 'spec_helper.rb'
require './bowling.rb'

describe Bowling do
  let!(:game) { Bowling.new([[1,1]]) }

  it "should accept an array of frames" do
    game = Bowling.new([[1,1], [10]])
    game.frames.should == [[1,1], [10]]
  end

  it "should sum a frame correctly" do
    game = Bowling.new([[5,5]])
    game.sum_frame(game.frames[0]).should == 10
  end

  it "should return zero if summing a nil frame" do
    game = Bowling.new([[5,5]])
    game.sum_frame(game.frames[1]).should == 0
  end

  it "should correctly determine when a spare is rolled" do
    game = Bowling.new([[5,5]])
    game.spare?(game.frames[0]).should be_true
  end

  it "should correctly determine when a strike is rolled" do
    game = Bowling.new([[10]])
    game.strike?(game.frames[0]).should be_true
  end

  it "should not return a spare if a strike is rolled" do
    game = Bowling.new([[10]])
    game.spare?(game.frames[0]).should be_false
  end

  it "should score a spare correctly" do
    game = Bowling.new([[4,6],[5,0]])
    game.score.should == 20
  end

  it "should score a strike correctly" do
    game = Bowling.new([[10,0],[5,4]])
    game.score.should == 28
  end

  it "should score two rolls without spare or strike correctly" do
    game = Bowling.new([[4,4]])
    game.score.should == 8
  end

  it "should correctly score multiple spares" do
    game = Bowling.new([[5,5],[2,8],[3,7],[6,4]])
    game.score.should == 51
  end

  it "should correctly calculate bonus if a spare is rolled" do
    game = Bowling.new([[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[3,3],[0,10],[6,0]])
    game.score.should == 70
  end

  it "should score correctly if no spares or strikes" do
    game = Bowling.new([[3,1],[2,0],[3,5],[3,6],[4,0],[0,5],[7,0],[8,1],[2,0],[0,0]])
    game.score.should == 50
  end

  it "should score correctly if all spares" do
    game = Bowling.new([[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[3,7],[10,0]])
    game.score.should == 137
  end

  it "should score 300 if one has a strike for every roll" do
    game = Bowling.new([[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,10]])
    game.score.should == 300
  end

  it "should score correctly if all strikes ending with no strike or spare" do
    game = Bowling.new([[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[10,0],[5,3]])
    game.score.should == 261
  end

end