# Bonamia

This is a Ruby wrapper on the [Bionomia](https://bionomia.net) API (name inspired by genus *[Bonamia](https://en.wikipedia.org/wiki/Bonamia)*). Code follow the spirit/approach of the Gem [serrano](https://github.com/sckott/serrano), and indeed much of the wrapping utility is copied 1:1 from that repo, thanks [@sckott](https://github.com/sckott).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bonamia'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bonamia

## Usage


---
### Suggest Collector Names
Get collector name suggestions:
```ruby
Bonamia.suggest('Smith, Ja', limit: 1) #  => MultiJson object
```

---
### Search Collectors
Search for collector:
```ruby
Bonamia.search_people('Thomas McElrath', families_collected: 'Monotomidae') #  => MultiJson object
```
---
### Search Occurrences
Search for occurrences by [GBIF](https://gbif.org) [datasetID](https://www.gbif.org/dataset/f86a681d-7db8-483b-819a-248def18b70a) and [occurrenceID](https://www.gbif.org/occurrence/1804069383):
```ruby
Bonamia.search_occurrences('f86a681d-7db8-483b-819a-248def18b70a', '7a1daa39-8d7c-d7c4-968f-799d58b3c7b0') #  => MultiJson object
```

---
### Collectors
Get a person's profile by their [ORCID](https://orcid.org/) or [WikiData](https://wikidata.org) identifiers:
```ruby
Bonamia.person('0000-0001-7618-5230') #  => JSON-LD object
```
---
### Specimens
Get a person's specimens by their [ORCID](https://orcid.org/) or [WikiData](https://wikidata.org) identifiers:
```ruby
Bonamia.person('0000-0001-7618-5230', specimens: true) #  => JSON-LD object
```

```ruby
Bonamia.person('0000-0001-7618-5230', specimens: true, csv: true) #  => comma-separated values
```
---
### Occurrences
Get an occurrence with a [GBIF](https://www.gbif.org/occurrence/search) occurrenceID:
```ruby
Bonamia.occurrence('477976412') #  => JSON-LD object
```
---
### Parsing human names
**Note:** [Bionomia](https://bionomia.net) provides a RESTful API for the human name parsing [dwc_agent](https://rubygems.org/gems/dwc_agent) gem which uses the [namae](https://rubygems.org/gems/namae) gem, and you likely will get better performance using those gems directly if parsing a large number of human names.

Parse authorships with names separated by `;` and each authorship set separated by `\r\n`:
```ruby
Bonamia.parse(names: 'Henry Robert Nicollon des Abbayes; Groom Q\r\nMrs. John Errol Chandos Aberdeen') #  => MultiJson object
```

---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SpeciesFileGroup/bonamia. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/SpeciesFileGroup/bonamia/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [NCSA/Illinois](https://github.com/SpeciesFileGroup/bonamia/blob/main/LICENSE.txt) license. You can learn more about the NCSA license on [Wikipedia](https://en.wikipedia.org/wiki/University_of_Illinois/NCSA_Open_Source_License) and compare it with other open source licenses at the [Open Source Initiative](https://opensource.org/license/uoi-ncsa-php/).

## Code of Conduct

Everyone interacting in the Bonamia project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SpeciesFileGroup/bonamia/blob/main/CODE_OF_CONDUCT.md).
