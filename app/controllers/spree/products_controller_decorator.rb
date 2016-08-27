require 'cassandra'
module Spree
  ProductsController.class_eval do
    after_action :save_recently_viewed

    private

    def save_recently_viewed
      id = params[:product_id]
      return unless id.present?
	
	  time1 = Time.now;
	  client = Cassandra.new('Spree', '127.0.0.1:9160')
	  client.insert(:ProductPageViews, time1.inspect+id,  {'timestamp' => time1.inspect,'product' => id})
    end
  end
end