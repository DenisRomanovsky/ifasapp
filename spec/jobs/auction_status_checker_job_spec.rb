require 'rails_helper'

RSpec.describe AuctionStatusCheckerJob, type: :job do
  let!(:auction) { FactoryGirl.create(:auction, mechanism_category:  FactoryGirl.create(:mechanism_category)) }
  let!(:auction_to_finish) { FactoryGirl.create(:auction, end_time: 10.seconds.ago, mechanism_category:  FactoryGirl.create(:mechanism_category)) }
  let!(:auction_finished) { FactoryGirl.create(:auction, status: :finished, mechanism_category:  FactoryGirl.create(:mechanism_category)) }
  let!(:auction_finished_with_end_time) { FactoryGirl.create(:auction, status: :finished, end_time: 10.hours.ago, mechanism_category:  FactoryGirl.create(:mechanism_category)) }

  it 'triggers jobs' do
    jobs_triggered = 0
    allow(AuctionFinalizerJob). to receive(:perform_later) { jobs_triggered += 1}
    AuctionStatusCheckerJob.new.perform
    expect(jobs_triggered).to eq(1)
  end
end
