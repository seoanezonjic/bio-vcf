module BioVcf
  module VcfSample

    # Check whether a sample is empty (on the raw string value)
    def VcfSample::empty? s
      s == './.' or s == '' or s == nil
    end

    class Sample
      # Initialized sample with rec and genotypefield
      #
      # #<BioVcf::VcfGenotypeField:0x00000001a0c188 @values=["0/0", "151,8", "159", "99", "0,195,2282"], @format={"GT"=>0, "AD"=>1, "DP"=>2, "GQ"=>3, "PL"=>4}, 
      def initialize rec,genotypefield
        @rec = rec
        @sample = genotypefield
        @format = @sample.format
        @values = @sample.values
      end

      def empty?
       cache_empty ||= VcfSample::empty?(@sample.to_s)
      end

      def eval expr, ignore_missing_data, quiet
        begin
          if not respond_to?(:call_cached_eval)
            code = 
            """
            def call_cached_eval(rec,sample)
              r = rec
              s = sample 
              #{expr}
            end
            """
            self.class.class_eval(code)
          end
          call_cached_eval(@rec,self)
        rescue NoMethodError => e
          $stderr.print "\nTrying to evaluate on an empty sample #{@sample.values.to_s}!\n" if not empty? and not quiet
          if not quiet
            $stderr.print [@format,@values],"\n"
            $stderr.print expr,"\n"
          end
          if ignore_missing_data
            $stderr.print e.message if not quiet and not empty?
            return false
          else
            raise
          end
        end
      end

      def sfilter expr, ignore_missing_data, quiet
        begin
          if not respond_to?(:call_cached_sfilter)
            code = 
            """
            def call_cached_sfilter(rec,sample)
              r = rec
              s = sample 
              #{expr}
            end
            """
            self.class.class_eval(code)
          end
          call_cached_sfilter(@rec,self)
        rescue NoMethodError => e
          $stderr.print "\nTrying to evaluate on an empty sample #{@sample.values.to_s}!\n" if not empty? and not quiet
          if not quiet
            $stderr.print [@format,@values],"\n"
            $stderr.print expr,"\n"
          end
          if ignore_missing_data
            $stderr.print e.message if not quiet and not empty?
            return false
          else
            raise
          end
        end
      end

      def ifilter expr, ignore_missing_data, quiet
        begin
          if not respond_to?(:call_cached_ifilter)
            code = 
            """
            def call_cached_ifilter(rec,sample)
              r = rec
              s = sample 
              #{expr}
            end
            """
            self.class.class_eval(code)
          end
          call_cached_ifilter(@rec,self)
        rescue NoMethodError => e
          $stderr.print "\nTrying to evaluate on an empty sample #{@sample.values.to_s}!\n" if not empty? and not quiet
          if not quiet
            $stderr.print [@format,@values],"\n"
            $stderr.print expr,"\n"
          end
          if ignore_missing_data
            $stderr.print e.message if not quiet and not empty?
            return false
          else
            raise
          end
        end
      end

      def efilter expr, ignore_missing_data, quiet
        begin
          if not respond_to?(:call_cached_efilter)
            code = 
            """
            def call_cached_efilter(rec,sample)
              r = rec
              s = sample 
              #{expr}
            end
            """
            self.class.class_eval(code)
          end
          call_cached_efilter(@rec,self)
        rescue NoMethodError => e
          $stderr.print "\nTrying to evaluate on an empty sample #{@sample.values.to_s}!\n" if not empty? and not quiet
          if not quiet
            $stderr.print [@format,@values],"\n"
            $stderr.print expr,"\n"
          end
          if ignore_missing_data
            $stderr.print e.message if not quiet and not empty?
            return false
          else
            raise
          end
        end
      end

      # Split GT into index values
      def gti
        v = fetch_values("GT")
        v.split(/\//).map{ |v| (v=='.' ? nil : v.to_i) }
      end

      # Split GT into into a nucleode sequence
      def gts
        gti.map { |i| (i ? @rec.get_gt(i) : nil) }
      end

      def cache_method(name, &block)
        self.class.send(:define_method, name, &block)
      end

      def method_missing(m, *args, &block)
        name = m.to_s.upcase
        if @format[name]
          cache_method(m) { 
            ConvertStringToValue::convert(fetch_values(name))
          }
          self.send(m)
        else
          super(m, *args, &block)
        end
      end  

  private

      def fetch_values name
        n = @format[name]
        raise "Unknown sample field <#{name}>" if not n
        @values[n]  # <-- save names with upcase!
      end

    end

  end
end
