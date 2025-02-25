PGDMP                      }            sales_db    15.10 (Homebrew)    17.0     m           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            n           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            o           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            p           1262    16392    sales_db    DATABASE     j   CREATE DATABASE sales_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE sales_db;
                     postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            q           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    4            �            1259    16413 	   marketing    TABLE     e   CREATE TABLE public.marketing (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.marketing;
       public         heap r       postgres    false    4            �            1259    16412    marketing_id_seq    SEQUENCE     �   CREATE SEQUENCE public.marketing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.marketing_id_seq;
       public               postgres    false    4    215            r           0    0    marketing_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.marketing_id_seq OWNED BY public.marketing.id;
          public               postgres    false    214            �            1259    16432 
   pembayaran    TABLE     �   CREATE TABLE public.pembayaran (
    id integer NOT NULL,
    transaction_id integer,
    amount bigint NOT NULL,
    payment_date date NOT NULL
);
    DROP TABLE public.pembayaran;
       public         heap r       postgres    false    4            �            1259    16431    pembayaran_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pembayaran_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.pembayaran_id_seq;
       public               postgres    false    219    4            s           0    0    pembayaran_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.pembayaran_id_seq OWNED BY public.pembayaran.id;
          public               postgres    false    218            �            1259    16420 	   penjualan    TABLE       CREATE TABLE public.penjualan (
    id integer NOT NULL,
    transaction_number character varying(50) NOT NULL,
    marketing_id integer,
    date date NOT NULL,
    cargo_fee bigint NOT NULL,
    total_balance bigint NOT NULL,
    grand_total bigint NOT NULL
);
    DROP TABLE public.penjualan;
       public         heap r       postgres    false    4            �            1259    16419    penjualan_id_seq    SEQUENCE     �   CREATE SEQUENCE public.penjualan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.penjualan_id_seq;
       public               postgres    false    4    217            t           0    0    penjualan_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.penjualan_id_seq OWNED BY public.penjualan.id;
          public               postgres    false    216            �           2604    16416    marketing id    DEFAULT     l   ALTER TABLE ONLY public.marketing ALTER COLUMN id SET DEFAULT nextval('public.marketing_id_seq'::regclass);
 ;   ALTER TABLE public.marketing ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    214    215    215            �           2604    16435    pembayaran id    DEFAULT     n   ALTER TABLE ONLY public.pembayaran ALTER COLUMN id SET DEFAULT nextval('public.pembayaran_id_seq'::regclass);
 <   ALTER TABLE public.pembayaran ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    219    218    219            �           2604    16423    penjualan id    DEFAULT     l   ALTER TABLE ONLY public.penjualan ALTER COLUMN id SET DEFAULT nextval('public.penjualan_id_seq'::regclass);
 ;   ALTER TABLE public.penjualan ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    216    217    217            f          0    16413 	   marketing 
   TABLE DATA           -   COPY public.marketing (id, name) FROM stdin;
    public               postgres    false    215   �       j          0    16432 
   pembayaran 
   TABLE DATA           N   COPY public.pembayaran (id, transaction_id, amount, payment_date) FROM stdin;
    public               postgres    false    219   �       h          0    16420 	   penjualan 
   TABLE DATA           v   COPY public.penjualan (id, transaction_number, marketing_id, date, cargo_fee, total_balance, grand_total) FROM stdin;
    public               postgres    false    217          u           0    0    marketing_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.marketing_id_seq', 3, true);
          public               postgres    false    214            v           0    0    pembayaran_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.pembayaran_id_seq', 9, true);
          public               postgres    false    218            w           0    0    penjualan_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.penjualan_id_seq', 12, true);
          public               postgres    false    216            �           2606    16418    marketing marketing_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.marketing
    ADD CONSTRAINT marketing_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.marketing DROP CONSTRAINT marketing_pkey;
       public                 postgres    false    215            �           2606    16425    penjualan penjualan_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.penjualan
    ADD CONSTRAINT penjualan_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.penjualan DROP CONSTRAINT penjualan_pkey;
       public                 postgres    false    217            �           2606    16426 %   penjualan penjualan_marketing_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.penjualan
    ADD CONSTRAINT penjualan_marketing_id_fkey FOREIGN KEY (marketing_id) REFERENCES public.marketing(id);
 O   ALTER TABLE ONLY public.penjualan DROP CONSTRAINT penjualan_marketing_id_fkey;
       public               postgres    false    217    215    3539            f   '   x�3�t�IK�K��2��M-��2�tI�K�K����� ��      j   >   x�3�442646�44 N##c] 2� �1�#������%'X
���	(����� �E�      h   �   x���I�0е}*��F�E��9��8��R��D��'0<�O"!э�&R������Q�
�+A�K�����9`	Y��s���6����[��#u��}MϦPʡm���j�6;{yv�GȱZ��_7R�{��,g&��5!�c[�_�|͝B�����X���yb~ �_7D|7	]�     