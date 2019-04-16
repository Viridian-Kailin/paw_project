# lib/db/dbloader.rb

require 'active_record'

class Db::Dbloader

  def self.load_all_YAML_from_files(pattern)
    db_connect

    Dir.glob(pattern).each do |path|
      load_YAML_from path
    end

  end

  def self.db_connect
    unless ActiveRecord::Base.connected?
      ActiveRecord::Base.establish_connection ENV['RAILS_ENV']
    end
  end

  def self.load_YAML_from(path)
    path =~ %r%([^/_]+)\.ya?ml$%
    table = $1

    modelname = table.singularize.to_sym
    classname = modelname.to_s
    classname[0] = classname[0].capitalize
    cls = classname.constantize

    #
    data = YAML::load_file path
    data.each do |id,attr|
      if attr.has_key?('id')&&(r=cls.find_by_id(attr['id']))
        r.update attr
      else
        clas.create attr
      end
    end
  end
end
