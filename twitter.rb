module Twitter
  class API < Grape::API
    format :json
    prefix :adparlor

    helpers do
      def client
        @client ||= Twitter::REST::Client.new do |config|
          config.consumer_key = ENV["TW_CONSUMER"]
          config.consumer_secret = ENV["TW_CONSUMER_SECRET"]
          config.access_token = ENV["TW_ACCESS_TOKEN"]
          config.access_token_secret = ENV["TW_ACCESS_TOKEN_SECRET"]
        end
      end

      def hashtags
        limit = params[:limit] > 2000 ? 2000 : params[:limit]
        @hashtags ||= client.user_timeline("adparlor", count: limit).collect { |response| response.hashtags.collect &:text }.flatten
      end

      def hashtag_count
        hashtags.each_with_object(Hash.new(0)) { |hashtag, count| count[hashtag] += 1 }.sort_by { |_,value| value }.reverse
      end
    end

    resource :analysis do
      desc 'Returns the most used hastags for a user'
      params do
        optional :limit, type: Integer, default: 2000
      end
      get do
        hashtag_count[0..9].to_h
      end
    end
  end
end
