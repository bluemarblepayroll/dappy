# frozen_string_literal: true

#
# Copyright (c) 2020-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe FileComposer::Blueprint do
  describe '#initialize' do
    describe 'preventing duplicate document names' do
      let(:case_documents) do
        [
          { type: :text, filename: 'hello_world_1.txt' },
          { type: :text, filename: 'hello_WORLD_1.txt' }
        ]
      end

      let(:type_documents) do
        [
          { type: :text, filename: 123 },
          { type: :text, filename: '123' }
        ]
      end

      it 'is case-insensitive' do
        expect { described_class.new(documents: case_documents) }.to raise_error(ArgumentError)
      end

      it 'is type-insensitive' do
        expect { described_class.new(documents: type_documents) }.to raise_error(ArgumentError)
      end
    end
  end
end
