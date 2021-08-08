require "colorize"
require "yaml"

module Learner
  class Push
    def run(target_file)
      p target_file
      p source_files = File.expand_path(File.join("../../finite_temp_vasp/templates/", target_file), @source_dir)
      file = source_files
      return if File.directory?(file)
      target = target_file
      puts "Pushing #{target} to templates...".green
      ans = "Y"
      if File.exist?(target)
        res = command_line "diff #{target} #{file}"
        puts_diff(res.stdout) unless res.stdout == ""
        print "Are you sure to push #{target} [Yn]? ".red
        ans = STDIN.gets
      end
      p ans[0]
      FileUtils.cp(target, file, verbose: true) if ans[0] == "Y"
      ""
    end

    def puts_diff(diff_text)
      diff_text.split("\n")[0..20].each do |line|
        if line.match(/^>/)
          puts "there:#{line}".on_light_cyan
        elsif line.match(/^</)
          puts "here:#{line}".on_light_white
        else
          puts line
        end
      end
    end
  end
end
