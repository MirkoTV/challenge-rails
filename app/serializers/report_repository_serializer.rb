class ReportRepositorySerializer < ActiveModel::Serializer
  attributes :name, :tags, :profile_id
end