--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: tboevil
--

COPY public.users (id, nickname, username, inserted_at, updated_at, role, avatar, introduction) FROM stdin;
3	student	student	2019-05-14 12:02:30	2019-05-15 10:00:25	0	https://wpimg.wallstcn.com/577965b9-bb9e-4e02-9f0c-095b41417191	暂无介绍
4	teacher	teacher	2019-05-15 09:58:24	2019-05-16 06:57:19	1	https://liqiu-1251740680.cos.ap-beijing.myqcloud.com/123wdsqwe123sadas.png	暂无介绍
5	admin	admin	2019-05-17 12:56:16	2019-05-17 12:56:16	2		暂无介绍
\.


--
-- Data for Name: quizs; Type: TABLE DATA; Schema: public; Owner: tboevil
--

COPY public.quizs (id, topic, user_id, inserted_at, updated_at) FROM stdin;
3	sdasdas	4	2019-05-16 07:57:10	2019-05-16 07:57:10
4	测试题目	4	2019-05-16 11:11:49	2019-05-16 11:11:49
5	测试题目	4	2019-05-16 11:12:32	2019-05-16 11:12:32
6	测试题目	4	2019-05-16 11:17:28	2019-05-16 11:17:28
7	测试题目	4	2019-05-16 11:23:34	2019-05-16 11:23:34
8	测试题目	4	2019-05-16 11:24:41	2019-05-16 11:24:41
9	测试题目	4	2019-05-16 11:32:02	2019-05-16 11:32:02
10	测试题目	4	2019-05-16 11:32:07	2019-05-16 11:32:07
\.


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: tboevil
--

COPY public.answers (id, score, content, user_id, quiz_id, inserted_at, updated_at) FROM stdin;
1	59	wdqdwqd	3	10	2019-05-16 11:34:09	2019-05-17 12:18:37
\.


--
-- Data for Name: credentials; Type: TABLE DATA; Schema: public; Owner: tboevil
--

COPY public.credentials (id, email, password_hash, user_id, inserted_at, updated_at) FROM stdin;
1	s@s.ss	$pbkdf2-sha512$160000$9SMqmKpcnNuKrFoCT.cApA$k5a12O36hA/e72i1xrpRF542iTMkkgnwklXM5f3EuWqO4JZNkrD3a20Nu0I8VN./LHdqAzJx8WAKkseYBhJ.eg	3	2019-05-14 12:02:30	2019-05-14 12:02:30
2	t@t.tt	$pbkdf2-sha512$160000$klnoq4UddTtHT9POUO.J3Q$HMgRJx4EkbendvS3yYNIMoVPFVP2X9LLiyHWqg4PrSVnNjjymBZ/s5DJojs1fIunqt2cm67rja2iTtU5JGJzRQ	4	2019-05-15 09:58:24	2019-05-15 09:58:24
3	a@a.aa	$pbkdf2-sha512$160000$lLytu4bphlv52S4nBqCkwA$chf89pWzgiqN0KISRNSk2q6n28v7pBHOmUaHkbGY0i4v9j7aedX5Jx0QI9PI/iA2iTDmhbwS7LAuQgmp4pBESA	5	2019-05-17 12:56:16	2019-05-17 12:56:16
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: tboevil
--

COPY public.rooms (id, title, cover, "desc", category, hot, user_id, inserted_at, updated_at, status, online) FROM stdin;
3	高等数学	https://liqiu-1251740680.cos.ap-beijing.myqcloud.com/1_我的自选.png	线性代数第一章	数学	t	4	2019-05-15 10:30:10	2019-05-18 16:39:35	f	1
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: tboevil
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20190405075503	2019-05-14 06:38:42
20190405084133	2019-05-14 08:10:22
20190514063404	2019-05-14 08:10:22
20190515024558	2019-05-15 02:49:55
20190515060442	2019-05-15 06:10:26
20190516021356	2019-05-16 03:48:57
20190516021623	2019-05-16 03:48:57
20190516045020	2019-05-18 16:44:31
20190519064818	2019-05-19 06:49:51
20190521043458	2019-05-21 04:46:00
\.


--
-- Data for Name: todos; Type: TABLE DATA; Schema: public; Owner: tboevil
--

COPY public.todos (id, status, content, user_id, inserted_at, updated_at) FROM stdin;
1	0	随便	4	2019-05-21 04:51:23	2019-05-21 04:51:23
2	0	线性代数	4	2019-05-21 07:23:52	2019-05-21 07:23:52
\.


--
-- Data for Name: user_rooms; Type: TABLE DATA; Schema: public; Owner: tboevil
--

COPY public.user_rooms (room_id, user_id, inserted_at, updated_at) FROM stdin;
3	3	2019-05-20 07:13:39	2019-05-20 07:13:39
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tboevil
--

SELECT pg_catalog.setval('public.answers_id_seq', 1, true);


--
-- Name: credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tboevil
--

SELECT pg_catalog.setval('public.credentials_id_seq', 3, true);


--
-- Name: quizs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tboevil
--

SELECT pg_catalog.setval('public.quizs_id_seq', 10, true);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tboevil
--

SELECT pg_catalog.setval('public.rooms_id_seq', 3, true);


--
-- Name: todos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tboevil
--

SELECT pg_catalog.setval('public.todos_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tboevil
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- PostgreSQL database dump complete
--

