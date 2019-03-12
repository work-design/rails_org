class InsertResignReasons < ActiveRecord::Migration[5.2]
  def change
    reasons = {
      'Company Environment': [
          'gap between corperate culture and personality',
          'crowded space',
      ],

      'Career Development': [
          'limited interet in the current business scope',
          'limited opportunity on personal development',
          'limited opportunity on trainings',
      ],

      'Compensation & Benifits': [
          'low ratio on social insurance and housing fund',
          'lack fairness on salary adjustment',
          'average welfare and benefit',
      ],

      'Work Pressure': [
          'not satisfied or intereted in the work content',
          'frequent overtime work',
          'heavy workload',
          'fast work pace',
          'poor morale within group',
          'intense relationship with superiors / colleagues',
      ],

      'Personal Matter': [
          'Further study',
          'Health condition',
          'Commute ',
          'Relocation',
      ],

      'Others': [
          '户口问题',
          '转办公室',
      ]
    }

    reasons.each do |parent_name, children_names|
      reason = ResignReason.create({
        name: parent_name
      })
      children_names.each do |name|
        ResignReason.create(
          {name: name, parent_id: reason.id}
        )
      end
    end
  end
end
