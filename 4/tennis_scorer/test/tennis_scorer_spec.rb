require_relative "../lib/tennis_scorer"

describe "TennisScorer", "basic scoring" do
  it "should start with a score of 0-0" do
    ts = TennisScorer.new
    ts.score.should == "0-0"
  end
  it "should be 15-0 if the server wins a point" do
    ts = TennisScorer.new
    ts.score_server
    ts.score.should == "15-0"
  end
  it "should be 0-15 if the receiver wins a point" do
    ts = TennisScorer.new
    ts.score_receiver
    ts.score.should == "0-15"
  end
  it "should be 15-15 after they both win a point" do
    ts = TennisScorer.new
    ts.score_server
    ts.score_receiver
    ts.score.should == "15-15"
  end
  it "should add 10 points after 30 points reached" do
    ts = TennisScorer.new
    ts.score_server
    ts.score.should == "15-0"
    ts.score_server
    ts.score.should == "30-0"
    ts.score_server
    ts.score.should == "40-0"
  end
  it "should display message \"Match!\" if server and receiver has 40 points" do
    ts = TennisScorer.new
    ts.score_server
    ts.score_receiver
    ts.score_server
    ts.score_receiver
    ts.score_server
    ts.score_receiver
    ts.message.should == "Match!"
  end
  it "should display message \"Server is winning!\" if server has more points than Receiver" do
    ts = TennisScorer.new
    ts.score_server
    ts.message.should == "Server is winning!"
    ts.score_receiver
    ts.score_server
    ts.message.should == "Server is winning!"
  end
  it "should display message \"New game \" if points are 0-0 and game just started" do
    ts = TennisScorer.new
    ts.message.should == "New game"
  end
  it "should display message \"New game - last game won Receiver\" if points are 0-0 and last game won Receiver" do
    ts = TennisScorer.new
    ts.score_receiver
    ts.score_receiver
    ts.score_receiver
    ts.score_receiver
    ts.message.should == "New game - last game won Receiver"
  end
  it "should display message \"New game - last game won Server\" if points are 0-0 and last game won Server" do
    ts = TennisScorer.new
    ts.score_server
    ts.score_server
    ts.score_server
    ts.score_server
    ts.message.should == "New game - last game won Server"
  end
  it "should display message \"Receiver is winning!\" if server has more points than Server" do
    ts = TennisScorer.new
    ts.score_receiver
    ts.message.should == "Receiver is winning!"
    ts.score_server
    ts.score_receiver
    ts.message.should == "Receiver is winning!"
  end
  it "should restart score after one of them has 60 points and the other one has less than 40" do
    ts = TennisScorer.new
    ts.score_server
    ts.score_server
    ts.score_server
    ts.score_server
    ts.score.should == "0-0"
  end

end
