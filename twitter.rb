module Twitter
  class API < Grape::API
    format :json
    prefix :adparlor

    resource :analysis do
      desc 'Returns the most used hastags for a user'
      params do
        optional :limit, type: Integer, default: 2000
      end
      get do
        limit = params[:limit] > 2000 ? 2000 : params[:limit]
        { someresult: limit }
      end
    end
  end
end
