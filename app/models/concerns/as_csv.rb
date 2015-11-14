module AsCSV

  def to_csv
    CSV.generate do |csv|
      csv << column_names.delete_if {|name| (name == 'id' || name == 'created_at' || name == 'updated_at')}
      all.each do |model|
        csv << model.attributes.values_at(*column_names)
      end
    end
  end

end
