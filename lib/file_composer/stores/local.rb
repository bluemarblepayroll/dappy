# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module FileComposer
  module Stores
    # File copier from local file system to the local file system.  This class will also
    # automatically shard the path with YYYY/MM/DD using the passed in date.  The date will default
    # to the current date in UTC unless specified otherwise.
    class Local
      attr_reader :date, :root

      def initialize(date: Time.now.utc.to_date, root: '')
        @date = date
        @root = root.to_s

        freeze
      end

      def move!(filename)
        make_final_filename(filename).tap do |final_filename|
          ensure_directory_exists(final_filename)
          FileUtils.mv(filename, final_filename)
        end
      end

      private

      def make_final_filename(filename)
        parts = random_filename_parts(File.extname(filename))

        File.join(*parts)
      end

      def random_filename_parts(extension)
        [
          root,
          date.year.to_s,
          date.month.to_s,
          date.day.to_s,
          "#{SecureRandom.uuid}#{extension}"
        ].compact
      end

      def ensure_directory_exists(filename)
        FileUtils.mkdir_p(File.dirname(filename))
      end
    end
  end
end
