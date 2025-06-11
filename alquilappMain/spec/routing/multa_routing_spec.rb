require "rails_helper"

RSpec.describe MultaController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/multa").to route_to("multa#index")
    end

    it "routes to #new" do
      expect(get: "/multa/new").to route_to("multa#new")
    end

    it "routes to #show" do
      expect(get: "/multa/1").to route_to("multa#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/multa/1/edit").to route_to("multa#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/multa").to route_to("multa#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/multa/1").to route_to("multa#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/multa/1").to route_to("multa#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/multa/1").to route_to("multa#destroy", id: "1")
    end
  end
end
