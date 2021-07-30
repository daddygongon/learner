# frozen_string_literal: true

module Learner
  # puts hello
  class Conf
    def pwd
      Dir.pwd
    end
    def check_conf
      File.exist?(File.join(Dir.pwd, ".learner.conf"))
    end
  end
end
