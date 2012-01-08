require 'erb'
require 'rspec/core/formatters/base_text_formatter'

module RSpec
  module Core
    module Formatters
      class OrgFormatter < BaseTextFormatter

        def initialize(output)
          super(output)
        end

        private
        def method_missing(m, *a, &b)
          # no-op
        end
        protected
        def section_level(example_or_group)
          if example_or_group.respond_to? :ancestors 
            example_or_group.ancestors.size
          else
             example_or_group.example_group.ancestors.size + 1
          end
        end
        # returs a string containing the right amount of * for an org section title
        # relative to an example or example_group
        def section_markup(example_or_group)
          '*' * (section_level example_or_group)
        end
        # returns a string containing the correct amount of spaces
        # to correctly indent the text inside the section relative
        # to an example or an example_group
        def section_indent(example_or_group)
          ' ' * (section_level example_or_group)
        end

        # returns the first line of the exception message text
        def exception_message_head (exception)
          nl = exception.message.index(?\n)
          if nl 
            exception.message.slice(0, nl)
          else
            exception.message
          end
        end

        # returns the exception message from the second line onwards
        def exception_message_body(exception)
          nl = exception.message.index(?\n)
          if nl
            exception.message[nl..-1]
          else
            nil
          end
        end
        
        # outputs an exception
        def output_exception(exception, example)
          @output.puts "#{section_indent example} #{exception_message_head exception}" unless exception.nil?
          exception_msg_body = exception_message_body exception
          if !(exception_msg_body.blank?)
            exception_msg_body = (exception_msg_body.strip.split("\n").map! { |line| "#{section_indent example}   #{line}" }).join("\n").chomp
            @output.puts "#{section_indent example} :DETAILS:"
            @output.puts exception_msg_body
            @output.puts "#{section_indent example} :END:"
          end
        end

        def org_link(file, line)
          current_dir = Dir.pwd
          "[[#{current_dir}#{file}::#{line}][#{file[1..-1]}:#{line}]]"
        end
        # outputs the backtrace of an exception
        def output_backtrace(exception, example)
          if (exception)
            @output.puts "#{section_indent example} *Backtrace*" 
            fmtbktr = format_backtrace exception.backtrace, example
            fmtbktr.each { |bktr| 
              file, line, rest = bktr.match(/(.*):(.*):(in.*)/).to_a.drop(1)
              if file.index('./') == 0
                file = file[1..-1]
              end
              @output.puts "#{section_indent example} #{org_link file, line} #{rest}"
            }
          end
        end

        # outputs the visibility properties for failed examples
        def output_failure_properties(example)
          @output.puts "#{section_indent example} :PROPERTIES:"
          @output.puts "#{section_indent example}   :VISIBILITY: children"
          @output.puts "#{section_indent example} :END:"
        end

        public
        def message(message)
        end

        # The number of the currently running example (a global counter)

        def start(example_count)
          super(example_count)
        end

        # returns the org section level for an example or an example_group

        def example_group_started(example_group)
          super(example_group)
          @output.puts "#{section_markup example_group} #{example_group.description}"
          @output.flush
        end

        def start_dump
          @output.puts "  </dl>"
          @output.puts "</div>"
          @output.flush
        end

        def example_passed(example)
          @output.puts "#{section_markup example} SUCCESS #{example.description}"
          @output.flush
        end



          
        def example_failed(example)
          super(example)
          exception = example.metadata[:execution_result][:exception]
          failure_style = RSpec::Core::PendingExampleFixedError === exception ? 'pending_fixed' : 'failed'
          # @header_red = true
          # @example_group_red = true
          @output.puts "#{section_markup example} #{failure_style.upcase} #{example.description}"
          output_exception(exception, example)
          output_backtrace(exception, example)
          output_failure_properties example
          @output.flush
        end

        def example_pending(example)
          message = example.metadata[:execution_result][:pending_message]
          @output.puts "#{section_markup example} PENDING #{example.description}"
          @output.puts "#{section_indent example} #{message}"
          @output.flush
        end



        def dump_failures
        end

        def dump_pending
        end

        def dump_summary(duration, example_count, failure_count, pending_count)
          # TODO - kill dry_run?
          @output.puts "* Summary"
          if dry_run?
            totals = "This was a dry-run"
          else
            totals =  "#{example_count} example#{'s' unless example_count == 1}, "
            totals << "#{failure_count} failure#{'s' unless failure_count == 1}"
            totals << ", #{pending_count} pending" if pending_count > 0
          end
          @output.puts "Finished in *#{duration} seconds*"
          @output.puts totals
          @output.puts "  :PROPERTIES:"
          @output.puts "    :VISIBILITY: children"
          @output.puts "  :END:"
          @output.puts "#+DRAWERS: DETAILS PROPERTIES"
          @output.puts "#+TODO: FAILED PENDING_FIXED PENDING | SUCCESS"
          @output.flush
        end
        
      end
    end
  end
end
