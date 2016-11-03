class AddStageOfJourneyToDrawing < ActiveRecord::Migration
  def change
    add_column :drawings, :stage_of_journey, :string
  end
end
