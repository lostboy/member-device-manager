require 'rails_helper'

describe ApplicationController do
  describe "#access_denied" do
    let!(:error) { double "error" }

    before { expect(error).to receive(:message).and_return("An error message.") }

    it "redirects to the root path" do
      expect(controller).to receive(:redirect_to).with(root_url, alert: "An error message.").once
      controller.access_denied(error)
    end
  end
end
