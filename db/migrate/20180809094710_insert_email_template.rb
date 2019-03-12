class InsertEmailTemplate < ActiveRecord::Migration[5.2]
  def change
    email_templates=[
        {
            name: '武汉人事助理岗位',
            subject: '',
            category: 'interview',
            body: <<EOF
Dear {{gender_title}} {{name}},

Thank you for the application for our HR Assistant position
advertised at http://jobs.zhaopin.com/588665423250196.html.
You may find all the necessary information there. The interview has two
rounds. The first round of interview is arranged as follows:

[*] Time
{{written_exam_time}}(please arrive 5 minutes earlier).

[*] Location
26th Floor, Shangwen Technology Mansion, No.6, Rd.JingAn, Wuchang
District, Wuhan 430074, China (http://www.mdpi.cn/about/contact)

[*] Materials
Please bring the followings with you:
- your English and Chinese CV;
- the original and the scanned copy of the identity card, diploma,
certificates and transcripts;

[*] About the interview
The interview will be several written examinations (60 minutes all
in English) and a face-to-face interview including oral English test.

Please prepare yourself well, and good luck!

Please reply and confirm. Thank you.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Wuhan PM',
            subject: 'MDPI {{office.name}} Office Interview Notice: {{name}} at {{written_exam_time}}',
            category: 'interview',
            body: <<EOF
Dear {{gender_title}} {{name}},

Thank you for the application for our Product manager position.
The interview has two rounds. The first round of interview is arranged as follows:

[*] Time
{{written_exam_time}}(please arrive 5 minutes earlier).

[*] Location
25th Floor, Shangwen Technology Mansion, No.6, Rd.JingAn, Wuchang
District, Wuhan 430074, China (http://www.mdpi.cn/about/contact)

[*] Materials
Please bring your English and Chinese CV

[*] About the interview
a face-to-face interview including oral English test.

Please prepare yourself well, and good luck!

Please reply and confirm. Thank you.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        },
        {
            name: '武汉-PHP开发工程师',
            subject: '曼迪匹艾（武汉）科技服务有限公司PHP开发工程师面试邀请，{{gender_title}} {{name}}，{{written_exam_time}}',
            category: 'interview',
            body: <<EOF
Dear {{gender_title}} {{name}}，

感谢您申请我公司PHP开发工程的招聘职位，我公司荣幸地邀请您参加此次招聘的能力测试，
关于此次测试的相 关安排如下：

[*]时间
{{written_exam_time}}

[*]地点
武汉市武昌区静安路6号尚文科技大厦25层

[*]所需材料
请携带完整的中英文简历来面试。

请回复邮件确定,谢谢。

曼迪匹艾（{{{city_chinese}}}）科技服务有限公司
人力资源部
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Wuhan Layout Interview Notice',
            subject: 'MDPI {{office.name}} Office Interview Notice: {{name}} at {{written_exam_time}}',
            category: 'interview',
            body: <<EOF
Dear {{gender_title}} {{name}}，

感谢您申请我公司在{{{zhilian}}}
上的招聘职位，您可在该页面找到所有关于我公司的必要信息。我公司荣幸地邀请
您参加此次招聘的能力测试，关于此次测试的相关安排如下：

[*]时间
{{written_exam_time}}

[*]地点
武汉市武昌区静安路6号尚文科技大厦18层

[*]所需材料
请携带以下材料并在参加测试前交给相关负责人员：
- 中英文简历；
- 身份证，学历证明，成绩单和技能证书的原件及复印件；

[*]面试流程
- 笔试（30min）：排版基础知识和逻辑测试题
- 实操（40min）：Word排版
- 面试（含英语口语测试）

[*] 注意事项
- 请自备手表和签字笔；
- 请提前5分钟到场。

请做好笔试的相关准备，祝好运！

请回复邮件确定。谢谢。

曼迪匹艾（{{{city_chinese}}}）科技服务有限公司
人力资源部
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Wuhan-Editor-Interview Notice',
            category: 'interview',
            subject: 'MDPI {{office.name}} Office Interview Notice: {{name}} at {{written_exam_time}}',
            body: <<EOF
Dear {{gender_title}} {{name}},

Thank you for the application for our Assistant Editors position
advertised at {{{zhilian}}}.
You may find all the necessary information there. The interview is
arranged as follows:

[*] Time
{{written_exam_time}}(please arrive 5 minutes earlier).

[*] Location
26th Floor, Shangwen Technology Mansion, No. 6, Rd. JingAn, Wuchang District, Wuhan (http://www.mdpi.cn/about/contact) (http://www.mdpi.cn/about/contact)

[*] Materials
Please bring the followings with you:
- your English and Chinese CV;
- the original and the scanned copy of the identity card, diploma,
certificates and transcripts;
- if you have any publications of articles, it is desirable to bring a
copy of it.

[*] About the interview
The interview will include the following:
1. Written test (30 mins)
2. Practice test (60 mins)
3. Face-to-face interview with oral English test

Please prepare yourself well, and good luck!

Please reply and confirm. Thank you.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Interview Notice-Haidian',
            subject: 'MDPI {{office.name}} Office Interview Notice: {{name}} at {{written_exam_time}}',
            category: 'interview',
            body: <<EOF
Dear {{gender_title}} {{name}},

Thank you for the application for our Assistant Editors position
advertised at {{{zhilian}}}.
You may find all the necessary information there. The interview is
arranged as follows:

[*] Time
{{written_exam_time}}(please arrive 5 minutes earlier).

[*] Location
{{office.address}} (http://www.mdpi.cn/about/contact)

[*] Materials
Please bring the followings with you:
- your English and Chinese CV;
- the original and the scanned copy of the diploma, English level certificates;
- if you have any publications of articles, it is desirable to bring a
copy of it.

[*] About the interview
The interview will include the following:
1. Written test (30 mins)
2. Practice test (60 mins)
3. Face-to-face interview with oral English test

Please prepare yourself well, and good luck!

Please reply and confirm. Thank you.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Interview Fail',
            category:'interview',
            subject: 'MDPI {{office.name}} Office Interview Result Notice: {{name}} - Failed',
            body: <<EOF
Dear {{gender_title}} {{name}},

Thank you for applying for our position as assistant editor in our company. We appreciate your interest in this position.

After careful assessment of your performance in the interview, we regret to inform you that we will not offer you further opportunity as your performance does not meet our requirements.

We are sorry that things didn't turn out well eventually. Anyway, thank you for your participation. Wish you a success in your future job hunting.

            MDPI China
        HR Department
        Tel. {{office_contact}}
EOF
        },
        {
            name: 'Offer',
            subject: 'MDPI {{office.name}} Office Offer Letter - {{name}}',
            category: 'offer',
            body: <<EOF
Dear {{gender_title}} {{name}},

We are pleased to inform you that you have passed our final training
test, thus we'd like to offer you the position of Assistant Editor in our company.

As discussed during your interviews, you will be working at our
{{office.name}} Office. You have been assigned to {{section.name}},
and will report directly to Section Leader and follow his/her assignments.

We will send you an email later which contains the materials you need to
hand in on the day you start working/internship, which is <strong>{{join_date}}</strong>.
Please reply to signify your understanding and acceptance about the
terms of this letter.

We are looking forward to having you join our company. Here, you will
be given a great platform to present your potential and develop your
career. Expect your dedications to the company.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Conversion Interview Notice',
            subject: 'MDPI {{office.name}} Office Interview Notice: {{name}} at {{written_exam_time}}',
            category: 'interview',
            body: <<EOF
Dear {{gender_title}} {{name}},

Thank you for the application for our Production Assistant position
advertised at {{{zhilian}}}.
You may find all the necessary information there and the interview is
arranged as follows:

[*] Time
{{written_exam_time}}(please arrive 5 minutes earlier).

[*] Location
{{office.address}} (http://www.mdpi.cn/about/contact)

[*] Materials
Please bring the followings with you:
- your English and Chinese CV;
- the original and the scanned copy of the identity card, diploma,
certificates and transcripts;

[*] About the interview
The interview will include the following:
1. Written test (30 mins)
2. Practice test (40 mins)
3. Face-to-face interview with oral English test

Please prepare yourself well, and good luck!

Please reply and confirm. Thank you.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Entry Notice',
            subject: 'MDPI新员工入职通知-{{name}}',
            category: 'entry',
            body: <<EOF
Dear {{gender_title}} {{name}},

通过公司对您本人简历的筛选，以及对您本人面试和培训环节，您已全面通过我们 公司的各项招聘审核，现公司正式以书面形式通知您--您已被我公司正 式录用。

入职报到后，公司将为您做入职介绍，包括公司企业文化、差旅制度、财务制度、 人事行政制度、IT管理制度及其他注意事项。如有任何疑问，请与人事部联系。

附件请查收入职前您需准备的材料，入职报到当天请一并提交给HR。谢谢合作。

曼迪匹艾（{{{city_chinese}}}）科技服务有限公司
人力资源部
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Editor Training Notice',
            subject: 'MDPI {{office.name}} Office Interview Result Notice: {{name}} - Training Program at {{training_begin}}',
            category: 'training',
            body: <<EOF
Dear {{gender_title}} {{name}},

We are glad to inform you that you have passed our interview. Hence
your training program has been arranged as follows:

Location:
{{office.address}}   (http://www.mdpi.cn/about/contact)

Time:
{{training_begin}}-{{training_end}}

Schedule:
1. Layout;
2. Finding referees;

Please reply and confirm. If you cannot attend due to any kind of emergency, please make sure to inform us in advance so we could
reschedule or make further arrangement accordingly. Thank you for your understanding and cooperation.

Good luck with the training and everything.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Editor Interview Notice',
            subject: 'MDPI {{office.name}} Office Interview Notice: {{name}} at {{written_exam_time}}',
            category: 'interview',
            body: <<EOF
Dear {{gender_title}} {{name}},

Thank you for the application for our Assistant Editors position
advertised at {{{zhilian}}}.
You may find all the necessary information there. The interview has two
rounds. The first round of interview is arranged as follows:

[*] Time
{{written_exam_time}}(please arrive 5 minutes earlier).

[*] Location
{{office.address}} (http://www.mdpi.cn/about/contact)

[*] Materials
Please bring the followings with you:
- your English and Chinese CV;
- the original and the scanned copy of the identity card, diploma,
certificates and transcripts;
- if you have any publications of articles, it is desirable to bring a
copy of it.

[*] About the interview
The interview will include the following:
1. Written test (30 mins)
2. Practice test (60 mins)
3. Face-to-face interview with oral English test

Please prepare yourself well, and good luck!

Please reply and confirm. Thank you.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Production Training Notice',
            subject: 'MDPI {{office.name}} Office Interview Result Notice: {{name}} - Training Program at {{training_begin}}',
            category: 'training',
            body: <<EOF
Dear {{gender_title}} {{name}},

We are glad to inform you that you have passed our interview. Hence
your training program has been arranged as follows:

Location:
{{office.address}}   (http://www.mdpi.cn/about/contact)

Time:
{{training_begin}}-{{training_end}}

Please reply and confirm. Thanks.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Layout Interview Notice',
            subject: 'MDPI {{office.name}} Office Interview Notice: {{name}} at {{written_exam_time}}',
            category: 'interview',
            body: <<EOF
Dear {{gender_title}} {{name}}，

感谢您申请我公司在{{{zhilian}}}
上的招聘职位，您可在该页面找到所有关于我公司的必要信息。我公司荣幸地邀请
您参加此次招聘的能力测试，关于此次测试的相关安排如下：

[*]时间
{{written_exam_time}}

[*]地点
{{office.chinese_address}}

[*]所需材料
请携带以下材料并在参加测试前交给相关负责人员：
- 中英文简历；
- 身份证，学历证明，成绩单和技能证书的原件及复印件；

[*]面试流程
- 笔试（30min）：排版基础知识和逻辑测试题
- 实操（40min）：Word排版
- 面试（含英语口语测试）

[*] 注意事项
- 请自备手表和签字笔；
- 请提前5分钟到场。

请做好笔试的相关准备，祝好运！

请回复邮件确定。谢谢。

曼迪匹艾（{{{city_chinese}}}）科技服务有限公司
人力资源部
Tel. {{office_contact}}
EOF
        },
        {
            name: 'Training Fail Notice',
            subject: 'MDPI {{office.name}} Office Training Fail Notice: {{name}}',
            category: 'training_fail_nptice',
            body: <<EOF
Dear {{gender_title}} {{name}},

Thank you for applying for our position as assistant editor in our
company. We appreciate your interest in this position.

After careful assessment of your performance in the training program, we
regret to inform you that we will not offer you further opportunity as
your performance does not meet our requirements.

We are sorry that things didn't work our well eventually. Anyway, thank
you for your participation. Wish you a success in your job hunting.

MDPI China
HR Department
Tel. {{office_contact}}
EOF
        }
    ]

    email_templates.each do |values|
      EmailTemplate.create({
          name: values[:name],
          subject: values[:subject],
          category: values[:category],
          body: values[:body]
      })
    end
  end
end
