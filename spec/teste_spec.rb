=begin
# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.file_fixture_path = 'spec/mock_files/'
end

RSpec.describe ImportFileJob do
  include ActiveJob::TestHelper

  let(:group) { Group.find_by(name: 'APP') }
  let(:company) { create(:company, group_uuid: group.uuid) }
  let(:workspace) { create(:workspace, company_id: company.id) }
  let(:import_file) { create(:import_file, company_id: company.id, workspace_id: workspace.id) }
  let(:call_job) { described_class.perform_later(group.uuid, import_file.id) }

  #para colocar o job numa queue de teste
  before do
    ActiveJob::Base.queue_adapter = :test

  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  describe 'with valid import file' do
    before { import_file.file.attach(io: file_fixture('only_valid_writeoffs.xlsx').open, filename: 'only_valid_writeoffs') }

    #para testar que foi colocado numa queue de teste
    it 'queues the job' do
      expect { call_job }.to change(enqueued_jobs, :size).by(1)
    end

    #testar se esta na queue especifica
    it 'queues the job in importing_file queue' do
      expect { call_job }.to have_enqueued_job(described_class).on_queue('importing_file')

    end

    #Executa o método perform do job
    it 'executes perform' do
      perform_enqueued_jobs { call_job }
    end
  end

  describe 'With invalid import file' do
    context 'with structural validations errors' do
      before { import_file.file.attach(io: file_fixture('invalid_structural_validation.xlsx').open, filename: 'invalid_structural_validation') }

      it 'update import file status to inactive' do
        expect { described_class.perform_now(group.uuid, import_file.id) }.to change{ import_file.reload.status }.from('loading').to('inactive')
      end
    end

    context 'with valid and invalid writeoffs' do
      before { import_file.file.attach(io: file_fixture('with_valid_and_invalid_writeoffs.xlsx').open, filename: 'with_valid_and_invalid_writeoffs') }

      it 'update import file status to inactive' do
        expect { described_class.perform_now(group.uuid, import_file.id) }.to change{ import_file.reload.status }.from('loading').to('active')
      end
    end

    context 'with all invalid writeoffs' do
      before { import_file.file.attach(io: file_fixture('only_invalid_writeoffs.xlsx').open, filename: 'only_invalid_writeoffs') }

      it 'update import file status to inactive' do
        expect { described_class.perform_now(group.uuid, import_file.id) }.to change{ import_file.reload.status }.from('loading').to('inactive')
      end
    end
  end
end
=end
