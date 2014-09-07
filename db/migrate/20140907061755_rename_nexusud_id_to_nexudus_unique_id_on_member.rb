class RenameNexusudIdToNexudusUniqueIdOnMember < ActiveRecord::Migration
  def change
    rename_column :members, :nexudus_id, :nexudus_unique_id
  end
end
