# Jsonr

require 'active_support/ordered_hash'
require 'active_support/json'

module Jsonr

  class Generator

    def initialize(&block)
      @commands = {}
      block.call(self) if block_given?
    end

    # Convert to a JSON string representation.
    def to_s
      ActiveSupport::JSON.encode(@commands)
    end

    # Replaces a content of an element with given selector with given value.
    #
    # Example:
    #
    #  # Redirect to persons listing.
    #  page.replace "#person_1", @person
    #
    def replace(selector, content)
      @commands[:replace] ||= {}
      @commands[:replace][selector] = content
    end

    # Appends given content to an element with given selector.
    #
    # Example:
    #
    #  # Redirect to persons listing.
    #  page.append "#persons", @person
    #
    def append(selector, content)
      @commands[:append] ||= {}
      @commands[:append][selector] = content
    end

    # Prepends given content to an element with given selector.
    #
    # Example:
    #
    #  # Redirect to persons listing.
    #  page.append "#persons", @person
    #
    def prepend(selector, content)
      @commands[:prepend] ||= {}
      @commands[:prepend][selector] = content
    end

    # Replaces an element with given selector with given value.
    #
    # Example:
    #
    #  # Redirect to persons listing.
    #  page.replace_with "#person_1", @person
    #
    def replace_with(selector, content)
      @commands[:replace_with] ||= {}
      @commands[:replace_with][selector] = content
    end

    # Inserts given content before an element with given selector.
    #
    # Example:
    #
    #  # Redirect to persons listing.
    #  page.insert_before "#persons", @person
    #
    def insert_before(selector, content)
      @commands[:insert_before] ||= {}
      @commands[:insert_before][selector] = content
    end

    # Redirects a client to a given url.
    #
    # Example:
    #
    #  # Redirect to persons listing.
    #  page.redirect_to persons_url
    #
    def redirect_to(url)
      @commands[:redirect_to] = url
    end

    # Displays a flash notice.
    #
    # Example:
    #
    #  # Show a flash message notice
    #  page.flash :notice, "A person detail's were updated."
    #
    def flash(severity, message)
      @commands[:flash] ||= ActiveSupport::OrderedHash.new
      @commands[:flash][severity] = message
    end

    # Hides elements with given +selectors+.
    #
    # Example:
    #
    #  # Hide a few people
    #  page.hide '#person_1', '#person_2'
    #
    def hide(*selectors)
      @commands[:hide] ||= []
      @commands[:hide].push *selectors
    end

    # Shows hidden elements with the given +selectors+.
    #
    # Example:
    #
    #  # Show a few people
    #  page.show '#person_1', '#person_2'
    #
    def show(*selectors)
      @commands[:show] ||= []
      @commands[:show].push *selectors
    end

    # Toggles the visibility of the elements with the given +selectors+.
    #
    # Example:
    #
    #  # Toggle a few people
    #  page.toggle '#person_1', '#person_2'
    #
    def toggle(*selectors)
      @commands[:toggle] ||= []
      @commands[:toggle].push *selectors
    end

    # Removes elements with the given +selectors+.
    #
    # Example:
    #
    #  page.remove '#person_1', '#person_2'
    #
    def remove(*selectors)
      @commands[:remove] ||= []
      @commands[:remove].push *selectors
    end

    # Sets given +key+ to a given +value+. Useful for passing custom objects.
    #
    # Example:
    #
    #  page.data :person, @person
    def data(key, value)
      @commands[key] = value
    end

  end

end