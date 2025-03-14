PGDMP      +                }            eis666    17.2    17.2 V    b           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            c           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            d           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            e           1262    16440    eis666    DATABASE     }   CREATE DATABASE eis666 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
    DROP DATABASE eis666;
                     postgres    false            �            1259    16481    budgets    TABLE     �   CREATE TABLE public.budgets (
    budget_id integer NOT NULL,
    department_id integer,
    budget_year integer NOT NULL,
    allocated_budget numeric(18,2) NOT NULL,
    used_budget numeric(18,2) DEFAULT 0
);
    DROP TABLE public.budgets;
       public         heap r       postgres    false            �            1259    16480    budgets_budget_id_seq    SEQUENCE     �   CREATE SEQUENCE public.budgets_budget_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.budgets_budget_id_seq;
       public               postgres    false    224            f           0    0    budgets_budget_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.budgets_budget_id_seq OWNED BY public.budgets.budget_id;
          public               postgres    false    223            �            1259    16455    departments    TABLE     }   CREATE TABLE public.departments (
    department_id integer NOT NULL,
    department_name character varying(100) NOT NULL
);
    DROP TABLE public.departments;
       public         heap r       postgres    false            �            1259    16454    departments_department_id_seq    SEQUENCE     �   CREATE SEQUENCE public.departments_department_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.departments_department_id_seq;
       public               postgres    false    218            g           0    0    departments_department_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.departments_department_id_seq OWNED BY public.departments.department_id;
          public               postgres    false    217            �            1259    16573 	   employees    TABLE     :  CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    nik character varying(20) NOT NULL,
    full_name character varying(100) NOT NULL,
    gender character varying(10),
    birth_date date NOT NULL,
    hire_date date NOT NULL,
    department_id integer,
    position_id integer,
    salary numeric(15,2) NOT NULL,
    email character varying(100),
    phone character varying(20),
    status character varying(20),
    deleted_at timestamp without time zone,
    CONSTRAINT employees_gender_check CHECK (((gender)::text = ANY ((ARRAY['Pria'::character varying, 'Wanita'::character varying])::text[]))),
    CONSTRAINT employees_status_check CHECK (((status)::text = ANY ((ARRAY['Aktif'::character varying, 'Cuti'::character varying, 'Resign'::character varying, 'Pensiun'::character varying])::text[])))
);
    DROP TABLE public.employees;
       public         heap r       postgres    false            �            1259    16572    employees_employee_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.employees_employee_id_seq;
       public               postgres    false    236            h           0    0    employees_employee_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;
          public               postgres    false    235            �            1259    16473    financial_reports    TABLE       CREATE TABLE public.financial_reports (
    report_id integer NOT NULL,
    report_type character varying(50),
    report_date date NOT NULL,
    revenue numeric(18,2),
    expenses numeric(18,2),
    net_profit numeric(18,2),
    assets numeric(18,2),
    liabilities numeric(18,2),
    deleted_at timestamp without time zone,
    CONSTRAINT financial_reports_report_type_check CHECK (((report_type)::text = ANY ((ARRAY['Laba Rugi'::character varying, 'Neraca'::character varying, 'Arus Kas'::character varying])::text[])))
);
 %   DROP TABLE public.financial_reports;
       public         heap r       postgres    false            �            1259    16472    financial_reports_report_id_seq    SEQUENCE     �   CREATE SEQUENCE public.financial_reports_report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.financial_reports_report_id_seq;
       public               postgres    false    222            i           0    0    financial_reports_report_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.financial_reports_report_id_seq OWNED BY public.financial_reports.report_id;
          public               postgres    false    221            �            1259    16555 	   inventory    TABLE     �   CREATE TABLE public.inventory (
    inventory_id integer NOT NULL,
    product_id integer,
    warehouse_id integer,
    stock_quantity integer NOT NULL
);
    DROP TABLE public.inventory;
       public         heap r       postgres    false            �            1259    16554    inventory_inventory_id_seq    SEQUENCE     �   CREATE SEQUENCE public.inventory_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.inventory_inventory_id_seq;
       public               postgres    false    234            j           0    0    inventory_inventory_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.inventory_inventory_id_seq OWNED BY public.inventory.inventory_id;
          public               postgres    false    233            �            1259    16464 	   positions    TABLE     w   CREATE TABLE public.positions (
    position_id integer NOT NULL,
    position_name character varying(100) NOT NULL
);
    DROP TABLE public.positions;
       public         heap r       postgres    false            �            1259    16463    positions_position_id_seq    SEQUENCE     �   CREATE SEQUENCE public.positions_position_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.positions_position_id_seq;
       public               postgres    false    220            k           0    0    positions_position_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.positions_position_id_seq OWNED BY public.positions.position_id;
          public               postgres    false    219            �            1259    16541    production_plans    TABLE     �   CREATE TABLE public.production_plans (
    plan_id integer NOT NULL,
    product_id integer,
    planned_quantity integer NOT NULL,
    actual_quantity integer DEFAULT 0,
    start_date date NOT NULL,
    end_date date NOT NULL
);
 $   DROP TABLE public.production_plans;
       public         heap r       postgres    false            �            1259    16540    production_plans_plan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.production_plans_plan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.production_plans_plan_id_seq;
       public               postgres    false    232            l           0    0    production_plans_plan_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.production_plans_plan_id_seq OWNED BY public.production_plans.plan_id;
          public               postgres    false    231            �            1259    16502    products    TABLE     �   CREATE TABLE public.products (
    product_id integer NOT NULL,
    product_name character varying(100) NOT NULL,
    category character varying(50),
    unit_price numeric(15,2),
    stock_quantity integer DEFAULT 0
);
    DROP TABLE public.products;
       public         heap r       postgres    false            �            1259    16501    products_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.products_product_id_seq;
       public               postgres    false    226            m           0    0    products_product_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;
          public               postgres    false    225            �            1259    16512    projects    TABLE     �  CREATE TABLE public.projects (
    project_id integer NOT NULL,
    project_name character varying(200) NOT NULL,
    client character varying(100),
    start_date date NOT NULL,
    end_date date,
    budget numeric(18,2),
    status character varying(50),
    CONSTRAINT projects_status_check CHECK (((status)::text = ANY ((ARRAY['On Progress'::character varying, 'Completed'::character varying, 'Cancelled'::character varying])::text[])))
);
    DROP TABLE public.projects;
       public         heap r       postgres    false            �            1259    16511    projects_project_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.projects_project_id_seq;
       public               postgres    false    228            n           0    0    projects_project_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.projects_project_id_seq OWNED BY public.projects.project_id;
          public               postgres    false    227            �            1259    16532 
   warehouses    TABLE     �   CREATE TABLE public.warehouses (
    warehouse_id integer NOT NULL,
    warehouse_name character varying(100) NOT NULL,
    location character varying(200)
);
    DROP TABLE public.warehouses;
       public         heap r       postgres    false            �            1259    16531    warehouses_warehouse_id_seq    SEQUENCE     �   CREATE SEQUENCE public.warehouses_warehouse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.warehouses_warehouse_id_seq;
       public               postgres    false    230            o           0    0    warehouses_warehouse_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.warehouses_warehouse_id_seq OWNED BY public.warehouses.warehouse_id;
          public               postgres    false    229            �           2604    16484    budgets budget_id    DEFAULT     v   ALTER TABLE ONLY public.budgets ALTER COLUMN budget_id SET DEFAULT nextval('public.budgets_budget_id_seq'::regclass);
 @   ALTER TABLE public.budgets ALTER COLUMN budget_id DROP DEFAULT;
       public               postgres    false    223    224    224            �           2604    16458    departments department_id    DEFAULT     �   ALTER TABLE ONLY public.departments ALTER COLUMN department_id SET DEFAULT nextval('public.departments_department_id_seq'::regclass);
 H   ALTER TABLE public.departments ALTER COLUMN department_id DROP DEFAULT;
       public               postgres    false    217    218    218            �           2604    16576    employees employee_id    DEFAULT     ~   ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);
 D   ALTER TABLE public.employees ALTER COLUMN employee_id DROP DEFAULT;
       public               postgres    false    236    235    236            �           2604    16476    financial_reports report_id    DEFAULT     �   ALTER TABLE ONLY public.financial_reports ALTER COLUMN report_id SET DEFAULT nextval('public.financial_reports_report_id_seq'::regclass);
 J   ALTER TABLE public.financial_reports ALTER COLUMN report_id DROP DEFAULT;
       public               postgres    false    221    222    222            �           2604    16558    inventory inventory_id    DEFAULT     �   ALTER TABLE ONLY public.inventory ALTER COLUMN inventory_id SET DEFAULT nextval('public.inventory_inventory_id_seq'::regclass);
 E   ALTER TABLE public.inventory ALTER COLUMN inventory_id DROP DEFAULT;
       public               postgres    false    234    233    234            �           2604    16467    positions position_id    DEFAULT     ~   ALTER TABLE ONLY public.positions ALTER COLUMN position_id SET DEFAULT nextval('public.positions_position_id_seq'::regclass);
 D   ALTER TABLE public.positions ALTER COLUMN position_id DROP DEFAULT;
       public               postgres    false    219    220    220            �           2604    16544    production_plans plan_id    DEFAULT     �   ALTER TABLE ONLY public.production_plans ALTER COLUMN plan_id SET DEFAULT nextval('public.production_plans_plan_id_seq'::regclass);
 G   ALTER TABLE public.production_plans ALTER COLUMN plan_id DROP DEFAULT;
       public               postgres    false    232    231    232            �           2604    16505    products product_id    DEFAULT     z   ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);
 B   ALTER TABLE public.products ALTER COLUMN product_id DROP DEFAULT;
       public               postgres    false    226    225    226            �           2604    16515    projects project_id    DEFAULT     z   ALTER TABLE ONLY public.projects ALTER COLUMN project_id SET DEFAULT nextval('public.projects_project_id_seq'::regclass);
 B   ALTER TABLE public.projects ALTER COLUMN project_id DROP DEFAULT;
       public               postgres    false    227    228    228            �           2604    16535    warehouses warehouse_id    DEFAULT     �   ALTER TABLE ONLY public.warehouses ALTER COLUMN warehouse_id SET DEFAULT nextval('public.warehouses_warehouse_id_seq'::regclass);
 F   ALTER TABLE public.warehouses ALTER COLUMN warehouse_id DROP DEFAULT;
       public               postgres    false    229    230    230            S          0    16481    budgets 
   TABLE DATA           g   COPY public.budgets (budget_id, department_id, budget_year, allocated_budget, used_budget) FROM stdin;
    public               postgres    false    224   wn       M          0    16455    departments 
   TABLE DATA           E   COPY public.departments (department_id, department_name) FROM stdin;
    public               postgres    false    218   �n       _          0    16573 	   employees 
   TABLE DATA           �   COPY public.employees (employee_id, nik, full_name, gender, birth_date, hire_date, department_id, position_id, salary, email, phone, status, deleted_at) FROM stdin;
    public               postgres    false    236   <o       Q          0    16473    financial_reports 
   TABLE DATA           �   COPY public.financial_reports (report_id, report_type, report_date, revenue, expenses, net_profit, assets, liabilities, deleted_at) FROM stdin;
    public               postgres    false    222   ?p       ]          0    16555 	   inventory 
   TABLE DATA           [   COPY public.inventory (inventory_id, product_id, warehouse_id, stock_quantity) FROM stdin;
    public               postgres    false    234   �p       O          0    16464 	   positions 
   TABLE DATA           ?   COPY public.positions (position_id, position_name) FROM stdin;
    public               postgres    false    220   �p       [          0    16541    production_plans 
   TABLE DATA           x   COPY public.production_plans (plan_id, product_id, planned_quantity, actual_quantity, start_date, end_date) FROM stdin;
    public               postgres    false    232   Nq       U          0    16502    products 
   TABLE DATA           b   COPY public.products (product_id, product_name, category, unit_price, stock_quantity) FROM stdin;
    public               postgres    false    226   �q       W          0    16512    projects 
   TABLE DATA           j   COPY public.projects (project_id, project_name, client, start_date, end_date, budget, status) FROM stdin;
    public               postgres    false    228   8r       Y          0    16532 
   warehouses 
   TABLE DATA           L   COPY public.warehouses (warehouse_id, warehouse_name, location) FROM stdin;
    public               postgres    false    230   �r       p           0    0    budgets_budget_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.budgets_budget_id_seq', 10, true);
          public               postgres    false    223            q           0    0    departments_department_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.departments_department_id_seq', 5, true);
          public               postgres    false    217            r           0    0    employees_employee_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.employees_employee_id_seq', 4, true);
          public               postgres    false    235            s           0    0    financial_reports_report_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.financial_reports_report_id_seq', 3, true);
          public               postgres    false    221            t           0    0    inventory_inventory_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.inventory_inventory_id_seq', 4, true);
          public               postgres    false    233            u           0    0    positions_position_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.positions_position_id_seq', 6, true);
          public               postgres    false    219            v           0    0    production_plans_plan_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.production_plans_plan_id_seq', 3, true);
          public               postgres    false    231            w           0    0    products_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.products_product_id_seq', 4, true);
          public               postgres    false    225            x           0    0    projects_project_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.projects_project_id_seq', 3, true);
          public               postgres    false    227            y           0    0    warehouses_warehouse_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.warehouses_warehouse_id_seq', 3, true);
          public               postgres    false    229            �           2606    16487    budgets budgets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_pkey PRIMARY KEY (budget_id);
 >   ALTER TABLE ONLY public.budgets DROP CONSTRAINT budgets_pkey;
       public                 postgres    false    224            �           2606    16462 +   departments departments_department_name_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_department_name_key UNIQUE (department_name);
 U   ALTER TABLE ONLY public.departments DROP CONSTRAINT departments_department_name_key;
       public                 postgres    false    218            �           2606    16460    departments departments_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (department_id);
 F   ALTER TABLE ONLY public.departments DROP CONSTRAINT departments_pkey;
       public                 postgres    false    218            �           2606    16584    employees employees_email_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);
 G   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_email_key;
       public                 postgres    false    236            �           2606    16582    employees employees_nik_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_nik_key UNIQUE (nik);
 E   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_nik_key;
       public                 postgres    false    236            �           2606    16580    employees employees_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public                 postgres    false    236            �           2606    16479 (   financial_reports financial_reports_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.financial_reports
    ADD CONSTRAINT financial_reports_pkey PRIMARY KEY (report_id);
 R   ALTER TABLE ONLY public.financial_reports DROP CONSTRAINT financial_reports_pkey;
       public                 postgres    false    222            �           2606    16560    inventory inventory_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);
 B   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_pkey;
       public                 postgres    false    234            �           2606    16469    positions positions_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (position_id);
 B   ALTER TABLE ONLY public.positions DROP CONSTRAINT positions_pkey;
       public                 postgres    false    220            �           2606    16471 %   positions positions_position_name_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.positions
    ADD CONSTRAINT positions_position_name_key UNIQUE (position_name);
 O   ALTER TABLE ONLY public.positions DROP CONSTRAINT positions_position_name_key;
       public                 postgres    false    220            �           2606    16547 &   production_plans production_plans_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.production_plans
    ADD CONSTRAINT production_plans_pkey PRIMARY KEY (plan_id);
 P   ALTER TABLE ONLY public.production_plans DROP CONSTRAINT production_plans_pkey;
       public                 postgres    false    232            �           2606    16508    products products_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public                 postgres    false    226            �           2606    16510 "   products products_product_name_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_product_name_key UNIQUE (product_name);
 L   ALTER TABLE ONLY public.products DROP CONSTRAINT products_product_name_key;
       public                 postgres    false    226            �           2606    16518    projects projects_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (project_id);
 @   ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_pkey;
       public                 postgres    false    228            �           2606    16537    warehouses warehouses_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (warehouse_id);
 D   ALTER TABLE ONLY public.warehouses DROP CONSTRAINT warehouses_pkey;
       public                 postgres    false    230            �           2606    16539 (   warehouses warehouses_warehouse_name_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.warehouses
    ADD CONSTRAINT warehouses_warehouse_name_key UNIQUE (warehouse_name);
 R   ALTER TABLE ONLY public.warehouses DROP CONSTRAINT warehouses_warehouse_name_key;
       public                 postgres    false    230            �           2606    16488 "   budgets budgets_department_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(department_id);
 L   ALTER TABLE ONLY public.budgets DROP CONSTRAINT budgets_department_id_fkey;
       public               postgres    false    218    224    4760            �           2606    16585 &   employees employees_department_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(department_id);
 P   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_department_id_fkey;
       public               postgres    false    218    236    4760            �           2606    16590 $   employees employees_position_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_position_id_fkey FOREIGN KEY (position_id) REFERENCES public.positions(position_id);
 N   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_position_id_fkey;
       public               postgres    false    236    4762    220            �           2606    16561 #   inventory inventory_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);
 M   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_product_id_fkey;
       public               postgres    false    234    226    4770            �           2606    16566 %   inventory inventory_warehouse_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_warehouse_id_fkey FOREIGN KEY (warehouse_id) REFERENCES public.warehouses(warehouse_id);
 O   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_warehouse_id_fkey;
       public               postgres    false    234    230    4776            �           2606    16548 1   production_plans production_plans_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.production_plans
    ADD CONSTRAINT production_plans_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);
 [   ALTER TABLE ONLY public.production_plans DROP CONSTRAINT production_plans_product_id_fkey;
       public               postgres    false    232    226    4770            S   [   x����	� E���bd������`��q!G���������"�.$�l���8|��ɶ�oI��v�4�B�87��f�J�ӈ�-�=�      M   J   x�3�(�O)�.��2��N-M�KO��2�.�MJ-RpI�LT�M�+-�L�2�Rs�2���O�,.������� ��      _   �   x�uнN�0����yGw�H�B����࢞�8(u���[W��统�& ����ۍ�i>��r�Ԃ$
��r�N�oy��c�{�'@{�t5&���s#�z��$�p�v5q�{x��S�\!M�2��,dOV�o���j)8�����]�ɇ��aV�x¤ *�
z ��R&o�K<LCI:�����'�$�UYΑ��2f���̑�Xȓ��"ղm�4�/m�j�      Q   f   x�3��ILJT*M��4202�50"NS�30�46E���P��j���2��K-JLND6=��Q����i6�t,*-V�N,F֎���C4# �+F��� Ϥ.^      ]   +   x���  ��a/�u���(Ul�V�v`k��I��x�l�      O   N   x�3��M�KLO-�2�.-H-*�,�/�2�t�K��K��p��K�����%�ii
ީ��y�y\fP� �=... ��      [   A   x�m���P��d�C�}���s��ׁ�m�p��[+�L$F��K?O��� ������u��      U   �   x�M��� Dϻ_�@��s5i޼�)�,���6�8����d4��/�$�3_ƪ]R)���5�������^R�!��טy�v�l=<�D�vp�L0����!-��>���Vx���,���>]�U���Q����i�1      W   �   x�u���0E��W�@J�cMtc4@�%�1L�))��-JH\8�dnfq�IDA�`��p#~�G(��G���&RI�oLtd�U��J���p�q4�Rd�)<�Gr��E��O/(l׎�(���4M�v+;D���el?t䩖�#����2AI�09q��ؓk�Vr��V�U&����XJ��`I�      Y   Y   x�3�t/MI�KW-I�M�tJ�K)�K�Q�J,OTpJ,J,�2�)qNQ�y���9�pE!���E\�0E>���%�ٜ^�ىE%�\1z\\\ ʻ �     