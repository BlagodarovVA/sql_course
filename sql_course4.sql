-- 104 INSERT
select * from employees;
select * from countries;
select * from regions;

INSERT into countries VALUES ('SW', 'Sweden', 1);
INSERT into countries VALUES ('GR', 'Greece');      -- ������, �� ��� �������� � �� ������� �������
INSERT into countries (country_id, country_name) VALUES ('GR', 'Greece');   -- ������ �� �����
update countries set region_id = 1 where country_name = 'Greece';

INSERT into countries (country_id, country_name, region_id)     -- �������� ��������� ����
VALUES ('NR', 'Norway', 1);

INSERT into countries VALUES ('ID', 'Indonesia', null);

INSERT into countries (country_id, country_name, region_id)
VALUES ('LY', 'Lyagushatiya', 1);



















