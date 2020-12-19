class ApplicationController < ActionController::API
  def json_response(service)
    if service.errors.any?
      render json: {status_code: ERROR_STATUS_CODE, error_msg: service.errors.join("; ")}, response_code: 400
    else
      render json: {status_code: SUCCESS_STATUS_CODE}.merge(service.send("#{params[:action]}_json_view")), response_code: 200
    end
  end
end
