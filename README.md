<a href="https://rubygems.org/gems/lowkey" title="Install gem"><img src="https://badge.fury.io/rb/lowkey.svg" alt="Gem version" height="18"></a> <a href="https://github.com/low-rb/lowkey" title="GitHub"><img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" alt="GitHub repo" height="18"></a> <a href="https://codeberg.org/Iow/key" title="Codeberg"><img src="https://img.shields.io/badge/Codeberg-2185D0?style=for-the-badge&logo=Codeberg&logoColor=white" alt="Codeberg repo" height="18"></a>

# Lowkey

PRISM is amazing and opens a new way to access metadata in Ruby. However:
- Loading and reloading the Abstract Syntax Tree (AST) multiple times is inefficient
- Higher level abstractions of the AST (classes, methods) are more useful
- Navigating the AST can be difficult

Lowkey provides a central API to make storing and accessing of the AST by multiple gems much easier.  
It's the secret sauce behind [LowType](https://github.com/low-rb/low_type), [LowLoad](https://github.com/low-rb/low_load) and [Raindeer](https://github.com/raindeer-rb/raindeer) in general.

## Usage

```ruby
Lowkey.load(file_path: 'my_class.rb')
Lowkey['my_class.rb'] # => FileProxy
Lowkey['MyNamespace::MyClass'] # => ClassProxy
```

## Proxies

Proxies are a higher level of abstraction above the Abstract Syntax Tree, to allow easy access to basic metadata.

**Proxy Types:**
- `FileProxy`
- `ClassProxy`
- `MethodProxy` [UNRELEASED]
- `ParamProxy` [UNRELEASED]
- `ReturnProxy` [UNRELEASED]

## Queries [UNRELEASED]

Queries allow you to get nodes within the AST via simple keypath syntax:
```ruby
Lowkey['MyNamespace::MyClass.my_method'] # => MethodDefNode
```

## Mutations [UNRELEASED]

Using the same keypath query syntax we can manipulate the AST:
```ruby
method_proxy = MethodProxy.new(my_params)
Lowkey['MyNamespace::MyClass.my_method'] = method_proxy
```
In the above example we have replaced the existing method with our own, using `MethodProxy` to easily build a new method.

## Exports [UNRELEASED]

Export a manipulated entities to memory with:
```ruby
Lowkey['my_class.rb'].export
Lowkey['MyNamespace::MyClass'].export
Lowkey['MyNamespace::MyClass.my_method'].export
```

Save manipulated entities to disk with:
```ruby
Lowkey['my_class.rb'].save(file_path:) # Replaces entire file.
Lowkey['MyNamespace::MyClass'].save(file_path:) # Replaces part of a file.
Lowkey['MyNamespace::MyClass.my_method'].save(file_path:) # Replaces part of a file.
```

## Config

Copy and paste the following and change the defaults to configure Lowkey:

```ruby
# This configuration should be set before calling "Lowkey.load".
Lowkey.configure do |config|
  # A big benefit of Lowkey is its caching of abstract syntax trees, file proxies and class proxies.
  # But to save memory you should clear them after the "class load"/setup stage of your application.
  # Set to "false" or call "Lowkey.clear" after you no longer need Lowkey, such as in a boot script.
  config.cache = true
end
```

## Installation

Add `gem 'lowkey'` to your Gemfile then:
```
bundle install
```
