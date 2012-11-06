require 'spec_helper'

describe Inflector, '.pluralize' do

  SingularToPlural = {
    'equipment'    => 'equipment',
    'information'  => 'information',
    'money'        => 'money',
    'species'      => 'species',
    'series'       => 'series',
    'fish'         => 'fish',
    'sheep'        => 'sheep',
    'news'         => 'news',
    'rain'         => 'rain',
    'milk'         => 'milk',
    'moose'        => 'moose',
    'hovercraft'   => 'hovercraft',
    'cactus'       => 'cacti',
    'thesaurus'    => 'thesauri',
    'matrix'       => 'matrices',
    'Swiss'        => 'Swiss',
    'life'         => 'lives',
    'wife'         => 'wives',
    'goose'        => 'geese',
    'criterion'    => 'criteria',
    'alias'        => 'aliases',
    'status'       => 'statuses',
    'axis'         => 'axes',
    'crisis'       => 'crises',
    'testis'       => 'testes',
    'child'        => 'children',
    'person'       => 'people',
    'potato'       => 'potatoes',
    'tomato'       => 'tomatoes',
    'buffalo'      => 'buffaloes',
    'torpedo'      => 'torpedoes',
    'quiz'         => 'quizzes',
    'vertex'       => 'vertices',
    'index'        => 'indices',
    'ox'           => 'oxen',
    'mouse'        => 'mice',
    'louse'        => 'lice',
    'thesis'       => 'theses',
    'thief'        => 'thieves',
    'analysis'     => 'analyses',
    'octopus'      => 'octopi',
    'grass'        => 'grass',
    'phenomenon'   => 'phenomena',
    'drive'        => 'drives',
  # ==== bugs, typos and reported issues

  # ==== rules and most common cases

    'forum'        => 'forums',
    'hive'         => 'hives',
    'athlete'      => 'athletes',
    'dwarf'        => 'dwarves',
    'hero'         => 'heroes',
    'zero'         => 'zeroes',
    'man'          => 'men',
    'woman'        => 'women',
    'sportsman'    => 'sportsmen',
    'branch'       => 'branches',
    'crunch'       => 'crunches',
    'trash'        => 'trashes',
    'mash'         => 'mashes',
    'cross'        => 'crosses',
    'erratum'      => 'errata',
  # FIXME: add -ia => -ium cases
  # FIXME: add -ra => -rum cases
    'ray'          => 'rays',
    'spray'        => 'sprays',
  # Merriam-Webster dictionary says
  # preys is correct, too.
    'prey'         => 'preys',
    'toy'          => 'toys',
    'joy'          => 'joys',
    'buy'          => 'buys',
    'guy'          => 'guys',
    'cry'          => 'cries',
    'fly'          => 'flies',
    'fox'          => 'foxes',
    'elf'          => 'elves',
    'shelf'        => 'shelves',
    'plus'         => 'plusses',
    'cat'          => 'cats',
    'rat'          => 'rats',
    'rose'         => 'roses',
    'project'      => 'projects',
    'post'         => 'posts',
    'article'      => 'articles',
    'location'     => 'locations',
    'friend'       => 'friends',
    'link'         => 'links',
    'url'          => 'urls',
    'account'      => 'accounts',
    'server'       => 'servers',
    'fruit'        => 'fruits',
    'map'          => 'maps',
    'income'       => 'incomes',
    'ping'         => 'pings',
    'event'        => 'events',
    'proof'        => 'proofs',
    'typo'         => 'typos',
    'attachment'   => 'attachments',
    'download'     => 'downloads',
    'asset'        => 'assets',
    'job'          => 'jobs',
    'city'         => 'cities',
    'package'      => 'packages',
    'commit'       => 'commits',
    'version'      => 'versions',
    'document'     => 'documents',
    'edition'      => 'editions',
    'movie'        => 'movies',
    'song'         => 'songs',
    'invoice'      => 'invoices',
    'product'      => 'products',
    'book'         => 'books',
    'ticket'       => 'tickets',
    'game'         => 'games',
    'tournament'   => 'tournaments',
    'prize'        => 'prizes',
    'price'        => 'prices',
    'installation' => 'installations',
    'date'         => 'dates',
    'schedule'     => 'schedules',
    'arena'        => 'arenas',
    'spam'         => 'spams',
    'bus'          => 'buses',
    'rice'         => 'rice',

    # Some specs from Rails
    'search'       => 'searches',
    'switch'       => 'switches',
    'fix'          => 'fixes',
    'box'          => 'boxes',
    'process'      => 'processes',
    'address'      => 'addresses',
    'case'         => 'cases',
    'stack'        => 'stacks',
    'wish'         => 'wishes',
                  
    'category'     => 'categories',
    'query'        => 'queries',
    'ability'      => 'abilities',
    'agency'       => 'agencies',
                  
    'archive'      => 'archives',
                  
    'safe'         => 'saves',
    'half'         => 'halves',
                  
    'move'         => 'moves',
                  
    'salesperson'  => 'salespeople',
                  
    'spokesman'    => 'spokesmen',
                  
    'basis'        => 'bases',
    'diagnosis'    => 'diagnoses',
    'diagnosis_a'  => 'diagnosis_as',
                  
    'datum'        => 'data',
    'medium'       => 'media',
                  
    'node_child'   => 'node_children',
                  
    'experience'   => 'experiences',
    'day'          => 'days',
                  
    'comment'      => 'comments',
    'foobar'       => 'foobars',
    'newsletter'   => 'newsletters',
                  
    'old_news'     => 'old_news',
                  
    'perspective'  => 'perspectives',
                  
    'photo'        => 'photos',
    'status_code'  => 'status_codes',
                  
    'house'        => 'houses',
    'virus'        => 'viruses',
    'portfolio'    => 'portfolios',
                  
    'matrix_fu'    => 'matrix_fus',
                  
    'axis'         => 'axes',
                  
    'shoe'         => 'shoes',
                  
    'horse'        => 'horses',
    'edge'         => 'edges',
                  
    'cow'          => 'cows' # 'kine' is archaic and nobody uses it
  }

  SingularToPlural.each do |singular, plural|
    it "pluralizes #{singular} => #{plural}" do
      Inflector.pluralize(singular).should eql(plural)
    end
  end

end
