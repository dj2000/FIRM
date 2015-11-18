module AsCSV

  def to_csv
    CSV.generate do |csv|
      csv << column_names.delete_if {|name| ['id', 'created_at', 'updated_at'].include?(name)}.map(&:titleize)
      all.each do |model|
        csv << model.attributes.values_at(*column_names)
      end
    end
  end

end
