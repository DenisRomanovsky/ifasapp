# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuctionFinalizerJob, type: :job do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:bidder_1) { FactoryGirl.create(:user) }
  let!(:bidder_2) { FactoryGirl.create(:user) }
  let!(:category) { FactoryGirl.create(:mechanism_category) }
  let!(:auction_to_finish) do
    FactoryGirl.create(:auction,
                       end_time: 10.seconds.ago,
                       user_email: nil,
                       owner: user,
                       mechanism_category: category)
  end
  let!(:quick_auction_to_finish) do
    FactoryGirl.create(:auction,
                       end_time: 10.seconds.ago,
                       mechanism_category: category)
  end

  it 'finalizes auction' do
    allow(UserMailer).to receive_message_chain(:auction_finished_owner_email, :deliver_later)
    AuctionFinalizerJob.new.perform(auction_to_finish.id)
    auction_to_finish.reload
    expect(auction_to_finish.status).to eq('finished')
  end

  it 'sends emails to owner' do
    triggered_owner_email = 0
    triggered_bidder_emails = 0
    mechanism = FactoryGirl.build(:mechanism)

    FactoryGirl.create(:bid, user: bidder_1, auction: auction_to_finish, mechanism: mechanism)
    FactoryGirl.create(:bid, user: bidder_2, auction: auction_to_finish, mechanism: mechanism)

    allow(UserMailer).to receive_message_chain(:auction_finished_owner_email,
                                               :deliver_later) { triggered_owner_email += 1 }
    allow(UserMailer).to receive_message_chain(:auction_finished_bidder_email,
                                               :deliver_later) { triggered_bidder_emails += 1 }

    AuctionFinalizerJob.new.perform(auction_to_finish.id)

    expect(triggered_owner_email).to eq(1)
    expect(triggered_bidder_emails).to eq(2)
  end

  it 'sends email to quick auction owner' do
    triggered_owner_email = 0
    allow(UserMailer).to receive_message_chain(:auction_finished_owner_email,
                                               :deliver_later) { triggered_owner_email += 1 }

    AuctionFinalizerJob.new.perform(quick_auction_to_finish.id)

    expect(triggered_owner_email).to eq(1)
  end
end
