class AttachmentsController < ApplicationController
  before_action :signed_in_user
  before_action :set_attachment, only: [:show, :destroy]

  def index
    # authorize! :read, user.attachments
    @attachments = current_user.attachments.most_recent_first.paginate(page: params[:page])
  end

  def show
    # authorize! :read, user.attachments
    send_file @attachment.media.path, type: @attachment.media_content_type,
      disposition: "inline"
  end

  def create
    @user = User.find(params[:user_id])
    # authorize! :update, @user
    @attachment = @user.attachments.create(attachment_params)
    redirect_to '/files'
  end

  def destroy
    user = @attachment.user
    authorize! :delete, @attachment
    @attachment.destroy
    redirect_to '/files'
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  def attachment_params
    params.require(:attachment).permit(:media)
  end

end
