# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'documents/text'
require_relative 'documents/zip'

module FileComposer
  # Factory for building documents.
  class Documents
    acts_as_hashable_factory

    register 'text', Documents::Text
    register 'zip',  Documents::Zip
  end
end
