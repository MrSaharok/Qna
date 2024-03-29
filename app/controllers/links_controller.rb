class LinksController < ApplicationController
  before_action :authenticate_user!, only: :destroy
  before_action :find_link

  authorize_resource

  def destroy
    @link.destroy if current_user&.author_of?(@link.linkable)
  end

  private

  def find_link
    @link = Link.find(params[:id])
  end
end
