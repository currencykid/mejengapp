class RenameColumnTitleinTablePostsToMejenga < ActiveRecord::Migration
  def change
    rename_column :posts, :title, :mejenga
  end
end
