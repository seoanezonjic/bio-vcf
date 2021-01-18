# No longer generated by jeweler
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bio-vcf"
  s.version = File.read("VERSION")

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pjotr Prins"]
  s.description = "Smart lazy multi-threaded parser for VCF format with useful filtering and output rewriting (JSON, RDF etc.)"
  s.email = "pjotr.public01@thebird.nl"
  s.executables = ["bio-vcf"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".travis.yml",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/bio-vcf",
    "bio-vcf.gemspec",
    "ragel/gen_vcfheaderline_parser.rl",
    "ragel/generate.sh",
  ]
  s.files += Dir['lib/**/*.rb'] + Dir['bin/*'] 
  s.files += Dir['[A-Z]*'] + Dir['test/**/*'] + Dir['features/**/*'] +
             Dir['template/**/*']
  
  s.homepage = "http://github.com/vcflib/bio-vcf"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  # s.rubygems_version = "2.0.3"
  s.summary = "Fast multi-purpose multi-threaded VCF parser"

end

