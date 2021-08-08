require "colorize"
require_relative "init"

module FiniteTempVasp
  class CLI::Pull < CLI::Init
    def run(target_file)
      #p source_files = File.expand_path(File.join("../../finite_temp_vasp/templates/", target_file), __FILE__)
      p source_files = File.expand_path(File.join("../../finite_temp_vasp/templates/", target_file), @source_dir)
      Dir.glob(File.join(source_files, "**/*")).sort.each do |file|
        next if File.directory?(file)
        res = file.split("/") - source_files.split("/")
        target = File.join(target_file, res)
        puts "Pulling #{target} from templates..."
        ans = "Y"
        if File.exist?(target)
          res = command_line "diff #{target} #{file}"
          next if res.stdout == ""
          puts_diff(res.stdout)
          print "Are you sure to pull #{target} [Yn]? ".red
          ans = STDIN.gets
        end
        FileUtils.cp(file, target) if ans[0] == "Y"
      end
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
