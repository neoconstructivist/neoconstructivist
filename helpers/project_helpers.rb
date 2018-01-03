module ProjectHelpers
  def valid_tags?(project)
    %i[strategies domains categories].any? { |type| project.send(type).present? }
  end
end
