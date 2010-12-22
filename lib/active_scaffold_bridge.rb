module ActiveScaffold::Config
  class Core < Base
    def initialize_with_timepicker(model_id)
      initialize_without_timepicker(model_id)

      timepicker_select_fields = self.model.columns.collect{|c| c.name.to_sym if [:datetime].include?(c.type) }.compact
      # check to see if file column was used on the model
      return if timepicker_select_fields.empty?

      # automatically set the form_ui to a file column
      timepicker_select_fields.each{|field|
        self.columns[field].form_ui = :timepicker
      }
    end

    alias_method_chain :initialize, :timepicker
  end
end


module ActiveScaffold
  module TimepickerBridge
    # Helpers that assist with the rendering of a Form Column
    module FormColumnHelpers
      def active_scaffold_input_timepicker(column, options)
        opts = options.merge(column.options)
        timepicker :record, column.name, options
      end
    end

    module SearchColumnHelpers
      def active_scaffold_search_timepicker(column, options)
        res = active_scaffold_search_range(column, options)
        res += javascript_tag(%Q|
          jQuery(function() {
            jQuery('##{options[:id]}').datetimepicker(jQuery.extend({showButtonPanel: true},    jQuery.datepicker.regional['ru']));
            jQuery('##{options[:id]}_to').datetimepicker(jQuery.extend({showButtonPanel: true}, jQuery.datepicker.regional['ru']));
          });
        |)
        res
      end
    end

    module ViewHelpers
      # Provides stylesheets to include with +stylesheet_link_tag+
      def active_scaffold_stylesheets(frontend = :default)
        super
        #super + [calendar_date_select_stylesheets]
      end

      # Provides stylesheets to include with +stylesheet_link_tag+
      def active_scaffold_javascripts(frontend = :default)
        super
        #super + [calendar_date_select_javascripts]
      end
    end

    module Finder
      module ClassMethods
        def condition_for_timepicker_type(column, value, like_pattern)
          value = {:from => value} unless value.is_a?(Hash)

          [:from, :to].each do |sub|
            value[sub] = Time.zone.parse(value[sub]) rescue nil if value.include?(sub) #or ActiveSupport::TimeZone.new('UTC').parse
          end

          raise RuntimeError unless value.include?(:from)

          if !value.include?(:opt)
            ["#{column.search_sql} = ?", value[:from].to_s(:db)]
          elsif ActiveScaffold::Finder::NullComparators.include?(value[:opt])
            condition = "#{column.search_sql} #{value[:opt].humanize}"
          elsif value[:from].blank?
            nil
          elsif value[:opt] == 'BETWEEN'
            ["#{column.search_sql} BETWEEN ? AND ?", value[:from].to_s(:db), value[:to].to_s(:db)]
          elsif ActiveScaffold::Finder::NumericComparators.include?(value[:opt])
            ["#{column.search_sql} #{value[:opt]} ?", value[:from].to_s(:db)]
          else
            nil
          end
        end

#       Это вариант если делать не range select а просто column[:from] - column[:to]
#        def condition_for_timepicker_type(column, value, like_pattern)
#          from_value, to_value = [:from, :to].collect do |sub|
#            ActiveSupport::TimeZone.new('UTC').parse(value[sub]) rescue nil
#            #Time.zone.parse(value[field]) rescue nil
#          end
#
#          if from_value.nil? and to_value.nil?
#            nil
#          elsif !from_value
#            ["#{column.search_sql} <= ?", to_value.to_s(:db)]
#          elsif !to_value
#            ["#{column.search_sql} >= ?", from_value.to_s(:db)]
#          else
#            ["#{column.search_sql} BETWEEN ? AND ?", from_value.to_s(:db), to_value.to_s(:db)]
#          end
#        end
      end
    end
  end
end

ActionView::Base.class_eval do
  include ActiveScaffold::TimepickerBridge::FormColumnHelpers
  include ActiveScaffold::TimepickerBridge::SearchColumnHelpers
  include ActiveScaffold::TimepickerBridge::ViewHelpers
end

ActiveScaffold::Finder::ClassMethods.module_eval do
  include ActiveScaffold::TimepickerBridge::Finder::ClassMethods
end
