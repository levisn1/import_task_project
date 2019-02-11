require 'csv'

desc "Import csv candidates into the database"

task candidates: :environment do
  filepath_candidates_csv = 'data/Import task - Candidates.csv'
  filepath_note_csv = 'data/Import task - Notes.csv'
  filepath_final_csv = 'data/Final.csv'

    candidates_fixed_phone = CSV.read(filepath_candidates_csv, headers: true).each do |array|
      if
        array[1].match(/\d{10}/) || array[1].match(/\d{10}/)
        array[2] = array[1]
        array[1] = ""
    end
  end

  # new_candidates = CSV.read(filepath_candidates_csv, headers: true).reject { |r| !r[1].include?("applicant") || r[1].include?("") }.uniq { |x| x.first }
  new_candidates = candidates_fixed_phone.reject { |r| r[1].include?("hello") }.uniq { |x| x.first }
  new_notes = CSV.read(filepath_note_csv, headers: true).uniq { |x| x.first }

  new_candidates_hash = new_candidates.each.map { |row|  {
    name: row[0],
    email: row[1],
    phone: row[2],
    job: row[3],
    created_at: row[4]
  }}

  new_note_hash = new_notes.each.map { |row| {
    email: row[0],
    note: row[1],
  }}

  final_hash = new_candidates_hash.each do |f|
    new_note_hash.each do |s|
      f.merge! s if f[:email] == s[:email]
    end
  end

  CSV.open('data/Final.csv', 'wb') do |csv|
    csv << %w(name email phone job created_at note)
    final_hash.each do |hsh|
      csv << hsh.values_at(:name, :email, :phone, :job, :created_at, :note)
      Candidate.create!(Name: hsh[:name], E_mail: hsh[:email], Phone: hsh[:phone], Job: hsh[:job], Created_at: hsh[:created_at], Note: hsh[:note])
    end
  end



end
