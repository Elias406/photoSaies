PGDMP                          z            fotosparati    12.11    12.11 -    F           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            G           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            H           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            I           1262    16393    fotosparati    DATABASE     �   CREATE DATABASE fotosparati WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Peru.utf8' LC_CTYPE = 'Spanish_Peru.utf8';
    DROP DATABASE fotosparati;
                postgres    false            �            1259    16395    cliente    TABLE     �   CREATE TABLE public.cliente (
    id smallint NOT NULL,
    nombre character varying(256),
    email character varying(256),
    contrasena character varying(256),
    activa boolean DEFAULT true
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            �            1259    16401    cliente_id_seq    SEQUENCE     w   CREATE SEQUENCE public.cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cliente_id_seq;
       public          postgres    false    202            J           0    0    cliente_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;
          public          postgres    false    203            �            1259    16403    admin    TABLE     �   CREATE TABLE public.admin (
    id smallint DEFAULT nextval('public.cliente_id_seq'::regclass) NOT NULL,
    nombre character varying(256),
    email character varying(256),
    contrasena character varying(256),
    activa boolean DEFAULT true
);
    DROP TABLE public.admin;
       public         heap    postgres    false    203            �            1259    16410    carro_compra    TABLE     n   CREATE TABLE public.carro_compra (
    id smallint NOT NULL,
    cliente_id smallint,
    foto_id smallint
);
     DROP TABLE public.carro_compra;
       public         heap    postgres    false            �            1259    16413    carro_compra_id_seq    SEQUENCE     |   CREATE SEQUENCE public.carro_compra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.carro_compra_id_seq;
       public          postgres    false    205            K           0    0    carro_compra_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.carro_compra_id_seq OWNED BY public.carro_compra.id;
          public          postgres    false    206            �            1259    16415    foto    TABLE     �   CREATE TABLE public.foto (
    id smallint NOT NULL,
    contenido character varying(256),
    titulo character varying,
    activa boolean DEFAULT true
);
    DROP TABLE public.foto;
       public         heap    postgres    false            �            1259    16422    foto_id_seq    SEQUENCE     t   CREATE SEQUENCE public.foto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.foto_id_seq;
       public          postgres    false    207            L           0    0    foto_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.foto_id_seq OWNED BY public.foto.id;
          public          postgres    false    208            �            1259    16424    lista_deseo    TABLE     �   CREATE TABLE public.lista_deseo (
    id smallint DEFAULT nextval('public.carro_compra_id_seq'::regclass) NOT NULL,
    cliente_id smallint,
    foto_id smallint
);
    DROP TABLE public.lista_deseo;
       public         heap    postgres    false    206            �            1259    16428    orden    TABLE     u   CREATE TABLE public.orden (
    id smallint NOT NULL,
    fecha date,
    cliente_id smallint,
    total smallint
);
    DROP TABLE public.orden;
       public         heap    postgres    false            �            1259    16431    orden_detalle    TABLE     m   CREATE TABLE public.orden_detalle (
    id smallint NOT NULL,
    orden_id smallint,
    foto_id smallint
);
 !   DROP TABLE public.orden_detalle;
       public         heap    postgres    false            �            1259    16434    orden_detalle_id_seq    SEQUENCE     }   CREATE SEQUENCE public.orden_detalle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.orden_detalle_id_seq;
       public          postgres    false    211            M           0    0    orden_detalle_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.orden_detalle_id_seq OWNED BY public.orden_detalle.id;
          public          postgres    false    212            �            1259    16436    orden_id_seq    SEQUENCE     u   CREATE SEQUENCE public.orden_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.orden_id_seq;
       public          postgres    false    210            N           0    0    orden_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.orden_id_seq OWNED BY public.orden.id;
          public          postgres    false    213            �
           2604    16438    carro_compra id    DEFAULT     r   ALTER TABLE ONLY public.carro_compra ALTER COLUMN id SET DEFAULT nextval('public.carro_compra_id_seq'::regclass);
 >   ALTER TABLE public.carro_compra ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    205            �
           2604    16439 
   cliente id    DEFAULT     h   ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);
 9   ALTER TABLE public.cliente ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202            �
           2604    16440    foto id    DEFAULT     b   ALTER TABLE ONLY public.foto ALTER COLUMN id SET DEFAULT nextval('public.foto_id_seq'::regclass);
 6   ALTER TABLE public.foto ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    207            �
           2604    16441    orden id    DEFAULT     d   ALTER TABLE ONLY public.orden ALTER COLUMN id SET DEFAULT nextval('public.orden_id_seq'::regclass);
 7   ALTER TABLE public.orden ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    213    210            �
           2604    16442    orden_detalle id    DEFAULT     t   ALTER TABLE ONLY public.orden_detalle ALTER COLUMN id SET DEFAULT nextval('public.orden_detalle_id_seq'::regclass);
 ?   ALTER TABLE public.orden_detalle ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    211            :          0    16403    admin 
   TABLE DATA           F   COPY public.admin (id, nombre, email, contrasena, activa) FROM stdin;
    public          postgres    false    204   �.       ;          0    16410    carro_compra 
   TABLE DATA           ?   COPY public.carro_compra (id, cliente_id, foto_id) FROM stdin;
    public          postgres    false    205   /       8          0    16395    cliente 
   TABLE DATA           H   COPY public.cliente (id, nombre, email, contrasena, activa) FROM stdin;
    public          postgres    false    202   A/       =          0    16415    foto 
   TABLE DATA           =   COPY public.foto (id, contenido, titulo, activa) FROM stdin;
    public          postgres    false    207   �/       ?          0    16424    lista_deseo 
   TABLE DATA           >   COPY public.lista_deseo (id, cliente_id, foto_id) FROM stdin;
    public          postgres    false    209   "0       @          0    16428    orden 
   TABLE DATA           =   COPY public.orden (id, fecha, cliente_id, total) FROM stdin;
    public          postgres    false    210   F0       A          0    16431    orden_detalle 
   TABLE DATA           >   COPY public.orden_detalle (id, orden_id, foto_id) FROM stdin;
    public          postgres    false    211   �0       O           0    0    carro_compra_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.carro_compra_id_seq', 60, true);
          public          postgres    false    206            P           0    0    cliente_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.cliente_id_seq', 6, true);
          public          postgres    false    203            Q           0    0    foto_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.foto_id_seq', 12, true);
          public          postgres    false    208            R           0    0    orden_detalle_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.orden_detalle_id_seq', 48, true);
          public          postgres    false    212            S           0    0    orden_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.orden_id_seq', 43, true);
          public          postgres    false    213            �
           2606    16444 #   lista_deseo carro_compra_copy1_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.lista_deseo
    ADD CONSTRAINT carro_compra_copy1_pkey PRIMARY KEY (id);
 M   ALTER TABLE ONLY public.lista_deseo DROP CONSTRAINT carro_compra_copy1_pkey;
       public            postgres    false    209            �
           2606    16446    carro_compra carro_compra_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.carro_compra
    ADD CONSTRAINT carro_compra_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.carro_compra DROP CONSTRAINT carro_compra_pkey;
       public            postgres    false    205            �
           2606    16448    admin cliente_copy1_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT cliente_copy1_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.admin DROP CONSTRAINT cliente_copy1_pkey;
       public            postgres    false    204            �
           2606    16450    cliente cliente_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    202            �
           2606    16452    foto foto_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.foto
    ADD CONSTRAINT foto_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.foto DROP CONSTRAINT foto_pkey;
       public            postgres    false    207            �
           2606    16454     orden_detalle orden_detalle_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.orden_detalle
    ADD CONSTRAINT orden_detalle_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.orden_detalle DROP CONSTRAINT orden_detalle_pkey;
       public            postgres    false    211            �
           2606    16456    orden orden_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.orden
    ADD CONSTRAINT orden_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.orden DROP CONSTRAINT orden_pkey;
       public            postgres    false    210            :   J   x�3��OJ-*��,��i�%���E�%�z�����F�@�Y�e��X��ș"q+3�,HM)ʇ�����qqq a�'�      ;      x�35�4�4�25R&\1z\\\ �      8   x   x�3��)�,����9z�����F�&��%\f��~����
�Q��~��y�z�U��y��E�yF騚��-,��8}�Ƣ� "��	gjNfb1�L�J/-�L-*J��0�,�+F��� �34      =   I   x�3�4��*H�<�X����Z�Y�e�ir����8��|�ҼD� �!��Z��
�qB��sA�c����  Z      ?      x�33�4�4����� m�      @   9   x�Uȱ�0���Ņ������w�[�t���dV��0����g�kF�zS�� ?�*       A   :   x����@B�o(���Z���!$�`bh���4��o%Fj�S1�����ߊ����
�     