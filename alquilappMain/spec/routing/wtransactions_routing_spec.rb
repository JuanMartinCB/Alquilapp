require "rails_helper"

RSpec.describe WtransactionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/wtransactions").to route_to("wtransactions#index")
    end

    it "routes to #new" do
      expect(get: "/wtransactions/new").to route_to("wtransactions#new")
    end

    it "routes to #show" do
      expect(get: "/wtransactions/1").to route_to("wtransactions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/wtransactions/1/edit").to route_to("wtransactions#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/wtransactions").to route_to("wtransactions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/wtransactions/1").to route_to("wtransactions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/wtransactions/1").to route_to("wtransactions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/wtransactions/1").to route_to("wtransactions#destroy", id: "1")
    end
  end
end
