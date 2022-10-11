class ReportProfileSerializer < ActiveModel::Serializer
  attributes :username, :repositories

  def repositories
    object.repositories.map do |repository|
      ReportRepositorySerializer.new(repository, scope: scope, root: false, event: object)
    end
  end
end