class AttachmentsController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :load_attachment

  def destroy
    @attachment.purge if current_user&.author_of?(@attachment.record)
  end

  private

  def load_attachment
    @attachment = ActiveStorage::Attachment.find_by(record_id: params[:id])
  end
end
