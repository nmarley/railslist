class AttachmentsController < ApplicationController
  before_action :signed_in_user
  before_action :set_attachment, only: [:show, :destroy]

  def index
    # authorize! :read, @attachment.list
    @attachments = current_user.attachments.most_recent_first.paginate(page: params[:page])
  end

  def show
    # authorize! :read, @attachment.list
    send_file @attachment.media.path, type: @attachment.media_content_type,
      disposition: "inline"
  end

  def create
    @list = List.find(params[:list_id])
    authorize! :update, @list
    @attachment = @list.attachments.create(attachment_params)
    redirect_to list_path(@list)
  end

  def destroy
    list = @attachment.list
    authorize! :delete, list
    @attachment.destroy
    redirect_to list_path(list.id)
  end


  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:media)
  end

end
