# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module FileComposer
  module Stores
    # File copier from local file system to the local file system.
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
          FileUtils.cp(filename, final_filename)
          FileUtils.rm(filename, force: true)
        end
      end

      private

      def make_final_filename(filename)
        parts = random_filename_parts(File.extname(filename))

        File.join(*parts)
      end

      def random_filename_parts(extension)
        [
          date.year.to_s,
          date.month.to_s,
          date.day.to_s,
          "#{SecureRandom.uuid}#{extension}"
        ].tap do |parts|
          parts.unshift(root) if root?
        end
      end

      def root?
        !root.empty?
      end

      def ensure_directory_exists(filename)
        FileUtils.mkdir_p(File.dirname(filename))
      end
    end
  end
end
