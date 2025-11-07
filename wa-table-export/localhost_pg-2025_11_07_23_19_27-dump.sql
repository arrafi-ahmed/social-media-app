--
-- PostgreSQL database dump
--

\restrict Gkxh7ffdjGj9RDRWP2iwsyBIZfOOVtvjzVYfgMebasefv2OXuxl5pKkwNPKzduU

-- Dumped from database version 16.10 (Ubuntu 16.10-1.pgdg24.04+1)
-- Dumped by pg_dump version 18.0 (Ubuntu 18.0-1.pgdg24.04+3)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (17, 'Faboya Family', 'Kemilekan12@gmail.com', '$2b$10$WfKSXADyovDq4Z5c1Meh1ekeWVDRZlU10ZKEnEB0MZGM0aoj4dywK', '1986-02-04', 'United Kingdom', 'user-1723471858969-51725.jpeg', 'faboya-family', 20, '2023-10-24 21:13:40');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (188, 'Tester', 'test@test.com', '$2b$10$QW00JmAMcfF.XWkf3QzewODbcokYZYpNilVnyVa4uLZ3DtgYfzHi2', NULL, NULL, NULL, 'tester', 20, '2024-07-13 02:03:49');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (29, 'Natalie', 'kunlefab12@gmail.com', '$2b$10$Q6rhjoR3ShCiVUQV62JHCulJM7LCYwPmq7/U875FY2dfwnOOTx3my', '1986-02-04', 'United Kingdom', 'user-1699545094577-79863.jpeg', 'natalie', 20, '2023-11-09 22:41:21');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (38, 'Graham & Nikki', 'niamold97@gmail.com', '$2b$10$/Hf9./sLfKeujvqyTK9g2epejkPm6Q2OBc.ywc.5u/iFU2tSPy9XS', '1970-09-24', 'United Kingdom', 'user-1699623937632-39943.jpeg', 'graham-nikki', 20, '2023-11-10 20:22:01');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (39, 'Nicola', 'Nicola.old73@gmail.com', '$2b$10$PYhWHlNZnJkaX73RH1s9iOFP1RPqhol7lAom/amAmE8WxGfrWCn1u', '1973-06-25', 'United Kingdom', NULL, 'nicola', 20, '2023-11-11 20:03:04');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (41, 'Robert Jones ', 'sjones1584@aol.com', '$2b$10$wS7qRYjWFS.ja5HDUYb1T.rFf3KRiL89Lxp9apmFhyHbkne9FF8qy', '1946-07-02', 'United Kingdom', NULL, 'robert-jones', 20, '2023-11-11 21:50:48');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (43, 'Amy Old', 'amy.old@outlook.com', '$2b$10$oNOEMfIwLhVgY8we5Npxf.5Q3VY0wWHXugUAWWf.DD0vtuKMOt6T2', '1997-01-30', 'United Kingdom', NULL, 'amy-old', 20, '2023-11-14 19:03:19');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (46, 'Simon Carroll', 'simon@simoncarroll.net', '$2b$10$XS/4Knte34dnxP.SVNvHQ.A6FyzyTPsAFp9UsjbVYkKIt20KR0KMK', '1963-05-15', 'United Kingdom', NULL, 'simon-carroll', 20, '2023-11-24 21:15:28');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (47, 'Matvii Haponenko', 'matviihaponenko@gmail.com', '$2b$10$NnHIfiMgzs0MXSEAMF2zo.P/yABaFIN4uVRRccr37/2vu/CZ.HfAG', '1989-12-10', 'Ukraine', NULL, 'matvii-haponenko', 20, '2023-11-28 12:26:36');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (48, 'Tharsh Thanga', 'tharshanth2@gmail.com', '$2b$10$nMFUS1OGnowOvfSlO15Pyul83M65tgKFvh3E/QFr2o/Z6lHcvms2O', '1992-08-03', 'Sri Lanka', NULL, 'tharsh-thanga', 20, '2023-11-28 13:03:12');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (50, 'Claire New', 'clairenew7850@gmail.com', '$2b$10$yWSFBpPz/Y00OwlogreuauNBHLvp9qQzRKdktICygQKz6A4rD1WzW', '1972-09-03', 'United Kingdom', NULL, 'claire-new', 20, '2023-11-28 16:24:46');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (51, 'Chloé Sova', 'sova.chloe@gmail.com', '$2b$10$xyYz9aRXkj3L3nBGjJtptup9gtXKOYPVQ8pDRiYUBJ4lhJXVT0es.', '1993-09-29', 'France', NULL, 'chlo-sova', 20, '2023-12-12 20:47:28');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (57, 'Anne SOWUNMI', 'annesowunmi@gmail.com', '$2b$10$JAXsYybBOi66CSmQQFSxfezmUJxnN6HyiGSNm3zxbBCp3oRIlKS2W', '1988-08-07', 'United Kingdom', NULL, 'anne-sowunmi', 20, '2023-12-22 00:27:39');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (58, 'Bill Nye', 'bill@thenyes.us', '$2b$10$Ss1b4HK0hBCcsWs.ExrPfedXh41R6JCLFPzxp6DLPSs.8oGF7n1vS', '1959-10-02', 'United States', NULL, 'bill-nye', 20, '2023-12-25 06:01:30');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (60, 'Floyd', 'Haydroksayd@yahoo.com', '$2b$10$uwFeaO5jfndxvlKNF3WUiurFopoD40BELoBEtnO7wJEWeWP8k.OuW', '1986-06-04', 'United Kingdom', NULL, 'floyd', 20, '2023-12-28 16:48:55');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (61, 'Aditi Roy', 'aditiroy4053@gmail.com', '$2b$10$jCmgO4YIVpYuLza6ZX/rAupy5myoLBcaDQMYWH9IoLYNuoKBFmcbe', '1986-04-10', 'India', NULL, 'aditi-roy', 20, '2023-12-28 16:50:38');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (63, 'Val Bcchs', 'Vtripier@icloud.com', '$2b$10$lVDN7tIiA0XixbB0vSC1jeBr5YJJzSiyhaj8z7t33C4F1/99VymNi', '1993-12-11', 'South Africa', NULL, 'val-bcchs', 20, '2023-12-28 17:14:06');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (64, 'Cindy Velt', 'Dreamsonthego@hotmail.com', '$2b$10$Kq28LmDZkoYXZqucFDH8XOQb5wv0umjBEoqqBbtwIym5tNnZ3unr.', '1977-12-04', 'Belgium', NULL, 'cindy-velt', 20, '2023-12-28 17:18:08');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (65, 'Kat', 'katrien_m@yahoo.com', '$2b$10$49cphH/176jKdK7ndbzTTudmvfBdKcEGGlxgRws.0pvSCMucnEKXG', '1982-01-09', 'Belgium', NULL, 'kat', 20, '2023-12-28 17:28:03');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (68, 'Louise Conradsson ', 'Louise.conradsson@hotmail.com', '$2b$10$jqmjAxrNfkHatTZ4acSnMOKzDR37wbI70F0sKfBjR/7EJLZDttmji', '1973-01-11', 'Sweden', NULL, 'louise-conradsson', 20, '2023-12-28 18:36:01');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (69, 'Bellatrix', 'Bellatrixbooks2020@gmail.com', '$2b$10$xt1Hx0UN6UjaZ9uyUkyoZ.VL.mkKS/rORwWQOSD33WmScY.lAQF.G', '2010-12-01', 'Jamaica', NULL, 'bellatrix', 20, '2023-12-28 19:08:23');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (71, 'Michaela Nill', 'michaelaparb@hotmail.com', '$2b$10$ArPPzkTNMnIdCVodtepYs.JQrTGJkVc1esKJ8F0nA5Jtl3XJxwYg.', '1982-06-02', 'Austria', NULL, 'michaela-nill', 20, '2023-12-28 19:19:24');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (72, 'Jasmin Kuttila', 'jasmin.kuttila@hotmail.com', '$2b$10$SliFLOEmWwBpNFroLq4ZueaQYKwzwl8kR1Dn/615C9X/h967p9VD2', '1996-02-09', 'Finland', NULL, 'jasmin-kuttila', 20, '2023-12-28 19:37:35');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (73, 'Rebecca g', 'Rebecca.greystone@gmail.com', '$2b$10$NFvHjUZxOc78MbJHM96NT.yHWHbLk15eZ4tK5Bj85lrjIjKMuXa5W', '1982-10-01', 'United States', NULL, 'rebecca-g', 20, '2023-12-28 21:14:36');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (76, 'Sarah Lovehart', 'Simifaboya@gmail.com', '$2b$10$DiTIBJUY2m28KDVnXlEpUuTsQc23IOrRDXqoykfjaYQuAJ1c6ekb.', '1991-03-12', 'Luxembourg', 'user-1704160527519-4833.jpeg', 'sarah-lovehart', 20, '2024-01-02 08:54:12');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (77, 'Jonathan', 'adelekanfaboya@gmail.com', '$2b$10$lVdBMyl4IgnniwiQsHhxAeQ3QG6opUxCHxpQkB4hdytUJ4EinrJVu', '1949-01-12', 'Andorra', 'user-1704160751512-64849.jpeg', 'jonathan', 20, '2024-01-02 08:57:23');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (88, 'Dane Kurian', 'danekurian90@gmail.com', '$2b$10$dxnAlFstk1PAJz7sO3orpe8nhiMePUrw4ovbLNFP2v8Yg4wyN.huu', '1990-11-04', 'United Kingdom', NULL, 'dane-kurian', 20, '2024-03-02 12:49:24');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (91, 'Katharine Matcham', 'katie.matcham@gmail.com', '$2b$10$XD5HG1zKg5YNNGE6Uf48D.lxRrHI0C88.9ggkKh4vlkX5UhKkWExe', '1969-11-04', 'United Kingdom', NULL, 'katharine-matcham', 20, '2024-03-19 12:02:05');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (94, 'Philippe', 'philthil@gmail.com', '$2b$10$.NPVo3bVdv6AkG1BbHU52.7lognrkKQem2jvnxCgi79/nXf.nC3iq', '1964-07-06', 'France', NULL, 'philippe', 20, '2024-04-10 23:22:54');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (97, 'Jamie', 'Jamie210674@yahoo.com.au', '$2b$10$EcBouIKblSpHQk5Mg2jFgOrjPdltmvRnvqJjBpOCTg.9oR.KrQqoe', NULL, NULL, NULL, 'jamie', 20, '2024-04-19 23:37:30');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (99, 'Suzanne Poorter', 'Suzanne@poorter.com', '$2b$10$p4T3eVvVldI0rWRPNx6/Seuu3I583VEQlyrPuq1057WuPme/Ck1Dy', NULL, NULL, NULL, 'suzanne-poorter', 20, '2024-04-24 21:33:16');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (101, 'Michael Archer', 'michael2472000@yahoo.co.uk', '$2b$10$FqYJMUKWAt5zTAv/2jHsOOBehE1KXv4VJqjgxJ0OD1.KW2I556uNC', NULL, NULL, NULL, 'michael-archer', 20, '2024-04-25 21:26:34');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (102, 'Soc Seamon', 'Sseamon@gmail.com', '$2b$10$cgenHjLTWxJc7sEmM4uMr.L/sAaNGHxWNbDlSu1UpguqcDsFPVVjq', NULL, NULL, NULL, 'soc-seamon', 20, '2024-04-28 06:45:14');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (105, 'jjjj', 'raguilerar8980@gmail.com', '$2b$10$sKWBfFEa1zRr0V/JE.tsG.xC.Vw2cK06TZRb5JeTrbQEeNAsYHs6.', NULL, NULL, NULL, 'jjjj', 20, '2024-04-30 03:40:52');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (106, 'MucAms', '12305@gmx.net', '$2b$10$zTvIGhKqeYecvr9c33xsCubp/uzLXNrMvk4Rl013ifElO4eR6/oV.', NULL, NULL, NULL, 'mucams', 20, '2024-05-02 01:17:02');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (108, 'Fay Burk', 'Phasesix@bigpond.com', '$2b$10$TB8ZsFp.h38dCmE0uwgLRu74zzzwnBSJZapgDIYAdFywNWWgoaTkS', NULL, NULL, NULL, 'fay-burk', 20, '2024-05-13 10:13:30');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (1, 'WayzAway', 'mannyfaboya@gmail.com', '$2b$10$.iYItFmMmNs28H.AV20ukeMdJLkWunAzwdo9wMrxHabcTQYCCMweu', '1993-02-01', 'United Kingdom', 'user-1717024780888-89556.jpeg', 'wayzaway', 10, '2023-10-08 09:40:57');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (111, 'Kristina Mihocic', 'maluminix@gmail.com', '$2b$10$2rhdM/iM5SiJ6xn2Sb4g1OwelymjAaVkNgR/TBGXjXLaSWnwSass2', NULL, NULL, NULL, 'kristina-mihocic', 20, '2024-05-23 02:33:57');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (113, 'Marc Deitzer', 'MarcDeitzer@gmail.com', '$2b$10$M7IiPEVcymclNrkM91F4Jejhrw6M3VUo6khSk6EBneFjpj/6QxBG.', NULL, NULL, NULL, 'marc-deitzer', 20, '2024-05-24 05:02:05');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (114, 'Philip Steinbacher', 'KauaiPAS@gmail.com', '$2b$10$FP5blQOdLSHRqZqSuRMFCef.xUiZmCmykK.nRoYvlNKgJ.ZPNFPBG', NULL, NULL, NULL, 'philip-steinbacher', 20, '2024-05-24 07:21:06');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (124, 'Liz ', 'Liz.dodds@sfctech.com.au', '$2b$10$5hjDqdyPUp/TS3qwwlIwpuxMLlEYfzsHmzPdCt9xuJV4y1bwgZaX.', NULL, NULL, NULL, 'liz', 20, '2024-05-30 16:52:57');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (126, 'Zoltán Istenes', 'zoltan.istenes@gmail.com', '$2b$10$tzvPbTd.b2mseWizsls2G.aWVIqertYoKv5L/1fLvEMm/PNzBHeZ6', NULL, NULL, NULL, 'zoltn-istenes', 20, '2024-06-01 23:33:45');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (127, 'Jeff B', 'Jeff49@duck.com', '$2b$10$oE/yoPwIeC6Tk.YZqJSoTuixNSB.HJNFtuMmO54UEbUnhm51KM/lu', NULL, NULL, NULL, 'jeff-b', 20, '2024-06-01 23:47:41');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (129, 'Jonathan Bordoli', 'jonathan.bordoli@pobox.com', '$2b$10$HkYYc6KxBzqSA7Yh1dBU8uD7wRfTIKJhBrpaXlP3C67BF8wE9yRVi', NULL, NULL, NULL, 'jonathan-bordoli', 20, '2024-06-02 19:54:16');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (169, 'Yas inukai', 'Yasyasyas@yahoo.com', '$2b$10$aWCgQhbyWGsV3dTIHxgvreE.0Uip7Zb87ZyPwzedpnZZAb92.XF.G', NULL, NULL, NULL, 'yas-inukai', 20, '2024-06-14 07:51:20');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (181, 'Steph', 'stephanieeebirch@gmail.com', '$2b$10$Ny7LUtLBOzsGBlbo4Ne7FunlMoniRiuD2OYTDyrNi4w1pmIxPBvEm', NULL, NULL, NULL, 'steph', 20, '2024-07-03 18:05:51');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (184, 'Monica Arun', '2024monicaarun@gmail.com', '$2b$10$3jr1OtrNhu2pRyDq1DHWDejqRa4wdkMFXGAYamqxXhCuMuH8A/5cG', NULL, NULL, NULL, 'monica-arun', 20, '2024-07-06 18:53:00');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (189, 'Carrie Littlejohn ', 'Carrielittlejohn@gmail.com ', '$2b$10$h2ZzRsP1ZyDMj1XujyTv8OmC7HFXNf1dIHA0cZVMrYf60qeCq36B6', NULL, NULL, NULL, 'carrie-littlejohn', 20, '2024-07-14 04:00:44');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (192, 'Lauren Hodge', 'lowl21xx@hotmail.co.uk', '$2b$10$0Xb6SlX82O1fJ3VN4tuR0u4rhuCx9NPq3HAdpJMJUyUciW4e5z.w6', NULL, NULL, NULL, 'lauren-hodge', 20, '2024-07-29 11:57:21');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (193, 'Register', 'register@register.com', '$2b$10$9PIrYUk01Nw7/XPapLOluOHAWApjCZUc0TXRe2LiL.GPTKqXvbvGW', NULL, NULL, NULL, 'register', 20, '2024-08-06 22:26:12');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (195, 'David Eldridge', 'Djeldridge01@gmail.com', '$2b$10$PEjHaWDpYHOcztX5xaOJ2OnNhfV8Tiz0fJNDSwAJyq73267pOBhuW', NULL, NULL, NULL, 'david-eldridge', 20, '2024-08-19 08:01:37');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (196, 'Jean Boone', 'Jeanaboone@gmail.com', '$2b$10$m.HHKQRn/5JhzTkxajVOROesp8l/kqc7WUN6KuPvzg8hkWNTIL7Ea', NULL, NULL, NULL, 'jean-boone', 20, '2024-08-20 14:36:25');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (197, 'Mikaël Rio', 'mikael.rio@gmail.com', '$2b$10$.ZQs.DoBLefQDSfv8VMedewMp3wQDdW7fYz6Xm3siVmCokrGk0CQy', NULL, NULL, NULL, 'mikal-rio', 20, '2024-08-24 14:34:12');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (200, 'Margaret Kennedy ', 'marg_kennedy@yahoo.com.au', '$2b$10$zP49exP.OGtn5Jt4D.YlH.VM3RyRWAAFNrH.qgG9wiES.j1su246i', NULL, NULL, NULL, 'margaret-kennedy', 20, '2024-08-28 08:50:43');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (201, 'Karin Jongman', 'Karin_jongman@hotmail.com', '$2b$10$MDjGpGJBiJRhnOvFGNWLJOfMO2tcL04J1zER1uaiVet5Xohpop54O', NULL, NULL, NULL, 'karin-jongman', 20, '2024-09-01 03:27:36');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (204, 'Catriona', 'Catriona.barry@me.com', '$2b$10$T1YIsYndqvRbuXIs/MD9e.ql2YLYifC0MXZ3zpxf1FzB9ammgIeOS', NULL, NULL, NULL, 'catriona', 20, '2024-09-10 22:02:53');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (206, 'Urs ', 'urs.groth@gmx.ch', '$2b$10$Mi44lRYuF3zsyEP/dE9zQuqyciQGVjaJIOP7YNZyZjbmnO6cwNVsy', NULL, NULL, NULL, 'urs', 20, '2024-09-28 21:29:03');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (208, 'Julien ', 'julienworldtrip@gmail.com', '$2b$10$LR4ocPxF0uz50oXMMCxLLusVm/qa/FciqbNdf8fDJZX6q2ofsiime', NULL, NULL, 'user-1728796843042-88243.jpeg', 'julien', 20, '2024-10-13 05:19:24');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (209, 'Gasteblé Didier', 'casto91@gmail.com', '$2b$10$4S2Lfy2t6BHP/3jI8HwSHee56H4dVhCWiSdHJxWqo.GoJpL6Lhtu2', NULL, NULL, NULL, 'gastebl-didier', 20, '2024-10-14 21:58:38');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (210, 'Sam Rees-Jones', 'Stickifrog@gmail.com', '$2b$10$Q43GJadNuOeVsEndsLhFjeWLrBAY44.PNseXxnztgbWxZfr/Vnf62', NULL, NULL, NULL, 'sam-rees-jones', 20, '2024-10-15 01:15:33');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (213, 'Chetan Nanjappa', 'chetannanjappa.kc@gmail.com', '$2b$10$aB2zkLAwxBcMCmkAD6Frde/A0l4kHc5CoKCBaSCRd1STpuhc361kK', NULL, NULL, NULL, 'chetan-nanjappa', 20, '2024-10-22 05:25:13');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (214, 'Hansu', 'Hansucamara256@gmail.com', '$2b$10$onV.jWuCMDRbRvWSEuWq.uURitaDmyNFt6M0KFa/BDTHNm2r36TSy', NULL, NULL, NULL, 'hansu', 20, '2024-10-23 17:45:44');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (216, 'Akoufe Hijazi', 'akoufehijazi@gmail.com', '$2b$10$UOyHj8uXnVD3us2N70DLIeSfZPd/LfaQlR67X51KVnYz9qxXA2KIW', NULL, NULL, NULL, 'akoufe-hijazi', 20, '2024-10-23 18:30:52');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (217, 'Karim Hijazi', 'karim3@me.com', '$2b$10$jCtPWM/C7y95KSwqOiiNE.f2f9kaaqoEtV0Tt0Mq.SL93dcBRUEZK', NULL, NULL, NULL, 'karim-hijazi', 20, '2024-10-23 18:48:28');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (219, 'Will', 'wilfredinho@icloud.com', '$2b$10$XKDDNjtdo001woqnSd6VCOJBF4m8AIuCGBXhsmhbPEBP.3uGVdPRS', NULL, NULL, NULL, 'will', 20, '2024-10-23 20:14:46');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (220, 'Wes Ward', 'wrward09@gmail.com', '$2b$10$qJGgKsBHjWWw90xAlgy.3.57kBS7kqik0jmLkBQHOdJAEpj8adCCa', NULL, NULL, NULL, 'wes-ward', 20, '2024-10-23 20:59:08');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (224, 'Kamilla Racz', 'kamilla.racz18@gmail.com', '$2b$10$GCj65rZsCi8mH1NI7oUDO.DDL8hGkLeAyP/t4sdvUgCg1m4QWGir2', NULL, NULL, NULL, 'kamilla-racz', 20, '2024-10-25 20:28:39');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (225, 'Elizabeth Norfrey', 'enorfrey@gmail.com', '$2b$10$LF01gGcvN83nyTwuK8HnMOAijpX6NGeFak.VF8r31s5Ihh67f9hRm', NULL, NULL, NULL, 'elizabeth-norfrey', 20, '2024-10-26 10:19:07');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (226, 'Joe Boon', 'joeboon99@yahoo.com', '$2b$10$6KDH89tmYDvnnn4BDYvWeOltSkf0um3EFb9NYSfSW23oyiOHAPCB2', NULL, NULL, NULL, 'joe-boon', 20, '2024-10-27 20:48:51');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (228, 'Piu Nath mandal', 'piunathmandal@gmail.com', '$2b$10$hRplUTHLk/Nd74YrAF1QZeVPe1Bb6JrZlLt/ZIypP2mSOxu5xEWZu', NULL, NULL, NULL, 'piu-nath-mandal', 20, '2024-11-13 04:35:09');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (229, 'Natalie Siebuhr', 'Natalieasiebuhr@gmail.com', '$2b$10$zFj/HNOAgTqhShdnuyWu4.NLG0B8v8SJHlC.qnOtZe7tc4BPn9bUu', NULL, NULL, NULL, 'natalie-siebuhr', 20, '2024-11-18 19:57:02');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (232, 'Rafael Pizarro', 'Rafpimey@gmail.com', '$2b$10$dBbMmaIw/tYZtDs9YM0V6OfY3ig1wPHsKXQ46bXLMnF2TS0fGpaGO', NULL, NULL, NULL, 'rafael-pizarro', 20, '2024-11-27 15:48:55');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (233, 'Daan Otten', 'daan.otten@ziggo.nl', '$2b$10$koHgRInEjP1sya1eiBBjX.EEf.4jUs4XPTptOr1tAWCRSfPth7E7K', NULL, NULL, NULL, 'daan-otten', 20, '2024-11-29 11:17:43');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (235, ' Jyo ', 'Jyothivareed@yahoo.co.uk', '$2b$10$ShEngoABVkzXWqxCQPdtluazenrPybeJvgVGSbdLMNegTmJJdc7gS', NULL, NULL, NULL, 'jyo', 20, '2024-12-25 00:42:13');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (236, 'Melisa Tan', 'MeLisa.Tan.HY@gmail.com', '$2b$10$3zawLdLShKwnTzOpnoSEXu6U0taC6iaXOY.nNqlxmFCoD6VBJCr6i', NULL, NULL, NULL, 'melisa-tan', 20, '2025-01-05 13:00:30');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (238, 'Robin', 'Robinwit@casema.nl ', '$2b$10$VRXAIApYRVRJYmTwAm6nA.ohdT8LHUfFZSQ9w4tTYGjFybJ3Xu.ya', NULL, NULL, NULL, 'robin', 20, '2025-01-07 19:27:51');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (241, 'Alex Kremer', 'Alex.Kremer2@gmail.com', '$2b$10$KBYmdszDVtfpwz3dMPP6P.k7dXEKuRzQFdyV1btQGoTTDVBmvVNrC', NULL, NULL, NULL, 'alex-kremer', 20, '2025-01-31 11:24:12');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (244, 'Sharon Hemmings', 'hemmings3@gmail.com', '$2b$10$P.eRjX1C9tA9SrRG21IMjOitIx.Ck7STkZMGx/cZ30m3Avc5X62ZS', NULL, NULL, NULL, 'sharon-hemmings', 20, '2025-03-09 03:46:03');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (245, 'Debroyer', 'veerledebroyer@gmail.com', '$2b$10$Rgnh.O2LflkynZWBcw59iev/bGUjyobZ31qKOdEx/Jx0mXLoEuxAS', NULL, NULL, NULL, 'debroyer', 20, '2025-03-09 17:02:40');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (247, 'Arnou ', 'emmanuelle.arnou@gmail.com', '$2b$10$Z2KtJbMz4gbMug90dpWGyOF.xnngj2UctB2NeeBVgzWeBTahvaSIm', NULL, NULL, NULL, 'arnou', 20, '2025-03-15 20:56:06');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (249, 'Jo Bu', 'jogebu@hotmaul.com', '$2b$10$usYNb4edSDkywO1BasfnI.na7DomB0fgjM06ymy.RKZJ0fvMn9rJ2', NULL, NULL, NULL, 'jo-bu', 20, '2025-04-12 08:38:11');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (251, 'Rheava Kirvin', 'rheava@me.com', '$2b$10$Y/vbjbA3UC03YsAVdl46Ae1zSy4x9RbBZL7B3K4bdoBkf5DvSPzeG', NULL, NULL, NULL, 'rheava-kirvin', 20, '2025-04-13 17:04:52');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (252, 'Fardoux Elie ', 'eliouxfx@gmail.com', '$2b$10$40Wx.CMc7fQMgrF1/3iTR.lQ.f4Fmbf.aRwkSDMUN1fvL0uSDCxE6', NULL, NULL, NULL, 'fardoux-elie', 20, '2025-04-27 10:46:53');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (256, 'Godmann ', 'gottraudgodmann@gmail.com', '$2b$10$n0I3lcfkX0jYIK38QJuswORlbw.BqUKgjewnaY7QTIWPu5C/t1bZ6', NULL, NULL, NULL, 'godmann', 20, '2025-06-16 20:52:12');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (258, 'francis chevalier', 'francis.chevalier4@orange.fr', '$2b$10$FKwlq0D2.fugYB.gDYJAueKbDfAVR9c4Wt8x3Bo9joP8Z21mH0zxW', NULL, NULL, NULL, 'francis-chevalier', 20, '2025-06-21 13:10:44');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (260, 'Emilie Ieven', 'emili_ie@hotmail.com', '$2b$10$u5nsXjUVx8CKnhQwzgn9f.tsmuQXKmrVLQIyalYJpptqCz.IDwRa2', NULL, NULL, NULL, 'emilie-ieven', 20, '2025-06-26 18:35:17');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (263, 'Neville Davies', 'nevdavies@gmail.com', '$2b$10$0BbBWDApI5a9OdxDSEdaz.FM85JW6EAsG/.ESlMc8tMWURunezdkS', NULL, NULL, NULL, 'neville-davies', 20, '2025-07-06 07:06:31');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (265, 'john pitton', 'jepetowangklief@gmail.com', '$2b$10$rdOdbz3V76Iikhz9ONmDueeQG6gffNuEUKIMYaeXASc6f.gdvtfkm', NULL, NULL, NULL, 'john-pitton', 20, '2025-07-20 18:55:31');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (267, 'Lince', 'galiza@jerez.es', '$2b$10$/6T0684w0xBX7BKoORguO.Kogi.TWBGRwDM/ceSVEwSFWkp7DV2Em', NULL, NULL, NULL, 'lince', 20, '2025-08-24 22:40:25');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (28, 'Andrew', 'sunmifaboya@gmail.com', '$2b$10$OBctGTW85.ahs7Erd3PK/.umitwZfxDZTpglZa1af4Q5xMsphdHQa', '1986-02-04', 'United Kingdom', 'user-1699545118922-18960.jpeg', 'andrew', 20, '2023-11-09 21:54:52');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (40, 'Graham Old ', 'graham.old70@gmail.com', '$2b$10$ldHToF.bcbhhiUvTNvEo4uY7tWmb0FJ1AySEDhtjzVitKYWhaUFA.', '1970-09-24', 'United Kingdom', NULL, 'graham-old', 20, '2023-11-11 20:12:39');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (44, 'Emma Harvey', 'Emmah@gmx.com', '$2b$10$xTVLnuSMZOBeZTCnMNeku.NzpPV463gTUkLYnc.nK735EkLqYoSjK', '1974-06-16', 'United Kingdom', NULL, 'emma-harvey', 20, '2023-11-15 01:44:24');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (49, 'Tech', 'rahul.monali103@gmail.com', '$2b$10$Dx5ijwDcn8OwShBUtTdmf.Gaf5UxdwT7tszk7e3GXoAiRBGpB9JQG', '1991-01-01', 'India', NULL, 'tech', 20, '2023-11-28 13:21:09');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (53, 'Capry Sisined', 'raf.utb@gmail.com', '$2b$10$RVg3ds5iS1SkZl577QzGLuPfvyZUX815A9ZCf1/ZNFEYxVH/x7ZYW', '1990-07-10', 'Angola', NULL, 'capry-sisined', 20, '2023-12-15 23:51:35');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (59, 'Dalia Beaini', 'daliabeaini1@gmail.com', '$2b$10$nIOyz9QDUqIbBLtfbkBbZevLlz6BYudazxs.TTd7Daz7rP7Yq4oY2', '1987-05-11', 'Australia', NULL, 'dalia-beaini', 20, '2023-12-27 15:20:46');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (62, 'Iolanda Grecu', 'iolanda.anne@gmail.com', '$2b$10$JhlrTcrvoDWjqRUr9IsLiu4kk2BCkgxut3ho.pUCWK.JDCikRkXQy', '1994-01-05', 'Romania', NULL, 'iolanda-grecu', 20, '2023-12-28 16:52:12');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (66, 'Marwin Madio', 'marwinmadio@gmail.com', '$2b$10$1ZqBdaJBbvfseuKGeQF/Vu6frDjXfLdRCZbScGOYbg.yI1hS.KEQi', '2010-05-04', 'Australia', NULL, 'marwin-madio', 20, '2023-12-28 18:10:04');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (70, 'Isabel Biggs', 'isabelbiggs123@hotmail.com', '$2b$10$pLQgdGqyQcanA.H/rFxap.y9AG34xdW6BCYCY26QZ8NX2r0DNObV2', '2001-01-10', 'United Kingdom', NULL, 'isabel-biggs', 20, '2023-12-28 19:14:36');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (74, 'Anna Paul ', 'gr8paul@gmail.com', '$2b$10$59vK3kmFVHe4Ya7eVgE1deRmlTmAVEEiu/AkqvkVEsdCzmV48B1hm', '1983-03-01', 'Canada', NULL, 'anna-paul', 20, '2023-12-29 05:01:48');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (87, 'Linda Jarrold ', 'lindajarrold@outlook.com', '$2b$10$9N6x3Pi2sjEOy53DmRb2Te3IpYWr/VbMDS05HpA7F.56oY.bg0HYe', '1964-06-30', 'United Kingdom', NULL, 'linda-jarrold', 20, '2024-02-01 13:38:55');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (96, 'Angela Smith', 'Ange.smudge@sky.com', '$2b$10$k6siN/Z9BkITAl76sd2xy.uD/ql.LrmqEpH0ajvCM2V0mr5xBzctG', NULL, NULL, NULL, 'angela-smith', 20, '2024-04-18 00:53:06');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (100, 'Mike ashby', 'drmsashby@gmail.com', '$2b$10$zqaxeO0TX8V4wsyHzhEDFuydZL.VXZPti8RWn/pJxxnckVzIZf2Km', NULL, NULL, NULL, 'mike-ashby', 20, '2024-04-25 19:52:31');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (103, 'Wouter D''hont', 'wouter@phimac.be', '$2b$10$xuziLFnOKVoZOmF17XZptuZy1Ca/sfcDN3xAsC2Y/vRO00Gaa1pMq', NULL, NULL, NULL, 'wouter-dhont', 20, '2024-04-28 22:23:52');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (107, 'Mahmood', 'Mahmoodsnober2005@icloud.com', '$2b$10$Pi35syAToJFcechmTLG/c.5GohbnwT999FEs6gcmFOtM16RiHgjwq', NULL, NULL, NULL, 'mahmood', 20, '2024-05-04 20:59:08');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (112, 'Gerhard Coetzee ', 'Gcoetzee@gmail.com', '$2b$10$3LJuiNC/whejXmHVp8.m.uYBzMMejYdqA/hKLsmcvHOvETjRMD6B2', NULL, NULL, NULL, 'gerhard-coetzee', 20, '2024-05-23 18:49:45');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (119, 'Harshith', 'harshithyker43@gmail.com', '$2b$10$L2IykmOe6XU8V0eAFS902OxNX76.83ta8rxGjuWyzP4cj80arkAKq', NULL, NULL, NULL, 'harshith', 20, '2024-05-28 16:54:01');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (128, 'Dakota Walker', 'Hello@dakotaearthcloud.com', '$2b$10$A20tfh4AEU6IkxqkDupRX.jCTGwsxa7LgntDrLKG./dbaH5bdiyjy', NULL, NULL, NULL, 'dakota-walker', 20, '2024-06-02 07:39:22');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (165, 'Janet Boulter ', 'Jan@nomadians.co.uk', '$2b$10$got4mnm2uRz1Vdj72TeJUeaKeBK9LTcuEJr6jKfEIg4icHAh375.O', NULL, NULL, NULL, 'janet-boulter', 20, '2024-06-13 13:47:52');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (172, 'Russ Bailey', 'russbailey1@gmail.com', '$2b$10$9vdRTo0y3JcE4sWV/0irzuGLO.z/M1v6YBTkvIdAtB5Mxo1Ix7n76', NULL, NULL, NULL, 'russ-bailey', 20, '2024-06-28 03:43:04');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (187, 'Becky Rodi', 'beckrodi@gmail.com', '$2b$10$x2n4kruy/5Ax9Kiv3fNfEudxlv94KyJ7Q9KKpS173YEqgaq3Njfj6', NULL, NULL, NULL, 'becky-rodi', 20, '2024-07-12 16:21:31');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (190, 'Amy Marie Borg', 'borgamymarie@gmail.com', '$2b$10$n6cEv98NyRhVCFaWS/t3MuRf8Mt5bqL.jkvPAA/69wAycA/LtpjdG', NULL, NULL, NULL, 'amy-marie-borg', 20, '2024-07-15 16:24:51');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (194, 'Gavin Tempero ', 'Gavin.tempero@gmail.com', '$2b$10$Usz0SFG4oOOmlabWkVXXh.K.BfqOrw27nCdbWqytPpco3rJ.fH9OO', NULL, NULL, NULL, 'gavin-tempero', 20, '2024-08-15 21:20:25');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (199, 'Eliot William ', 'eliotilluminate114@gmail.com', '$2b$10$NwdFbciJtOH2bi9voNHcz.Twnytukq9nMroH4nHfaMuGJQwz/f7Kq', NULL, NULL, NULL, 'eliot-william', 20, '2024-08-27 21:44:39');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (202, 'darshna', 'darshna.jhanjhan@kpnmail.nl', '$2b$10$RMLjL1dxId/tAZ4TidyPGu7MuEypXBaZH3I5NgrWzgtGJsya.O3A.', NULL, NULL, NULL, 'darshna', 20, '2024-09-05 10:06:34');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (207, 'Renvoyé vahinetua ', 'vahineteai@hotmail.fr', '$2b$10$.BHg260OwoMXiDSJjehpbe8QEv1zxZDTbKiX4fAeBQQDxYtwyTKLW', NULL, NULL, NULL, 'renvoy-vahinetua', 20, '2024-10-12 16:54:57');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (211, 'Roy Evans', 'evansent24@gmail.com', '$2b$10$dM2dRBWfzm0/r.sEFER/ruZ3/KU6YGFIiG7UhxjCxqnHPWt7MHBES', NULL, NULL, NULL, 'roy-evans', 20, '2024-10-20 11:42:22');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (215, 'Tom Trahearn', 'Thomastrahearn@hotmail.co.uk', '$2b$10$fEWolErA/oEgE1osxcgXXeI.KxqKMccQ1C2H7DD/GBA.ZKzOcnb2a', NULL, NULL, NULL, 'tom-trahearn', 20, '2024-10-23 17:52:20');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (218, 'Ionut adrian ion', 'Adrianionut7007@gmail.com', '$2b$10$woxTai2RutOG5DZtgl/el.287Xj4JLzBlZhuZo4SxCoJyRnbA.UBi', NULL, NULL, NULL, 'ionut-adrian-ion', 20, '2024-10-23 19:08:21');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (222, 'Sam McFall', 'sam-mcfall@outlook.com', '$2b$10$B3y6TYudIcuB5r96hp/I0uWOFthhDn15jqUqdEjgH9T/hV9ss.DgG', NULL, NULL, NULL, 'sam-mcfall', 20, '2024-10-24 13:37:59');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (227, 'Michelle Poller', 'Michelle.poller@googlemail.com', '$2b$10$AycRgkrjdj2eV9hbNg/rh.cSkgnmMaqvW1QxMUzilVaC8xOoAzWQq', NULL, NULL, NULL, 'michelle-poller', 20, '2024-11-03 20:43:02');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (231, 'Benjamin Thr', 'Therreau.benjamin@gmail.com', '$2b$10$Da2kv6t.M5HQx3KxQeFeZuCQVlQVfIQwN0MwKEgO/H4Bg.nAc5oJi', NULL, NULL, NULL, 'benjamin-thr', 20, '2024-11-24 21:41:11');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (234, 'Tahmid jubayer', 'isjubayer604@gmail.com', '$2b$10$emzr5xYfQ530DchHWV88rOdH7wR0ih21KgjVePscxb.t1d7eFFcOW', NULL, NULL, NULL, 'tahmid-jubayer', 20, '2024-12-12 05:40:42');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (56, 'Steph Faboya', 'Steph.birch@talk21.com', '$2b$10$qz2NhugaXgmxfpS8B8HVeO2PCT6MFsAfhal1aX2o6WiNtSvcyUyxG', '1986-01-02', 'United Kingdom', NULL, 'steph-faboya', 20, '2023-12-21 09:10:23');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (67, 'Patricia Dantas', 'patriciadantastravel@gmail.com', '$2b$10$VCbrM3p49tTUF1cD6oowju4LHRll4beFpYn1ZNZH49ehD/ZdrqlC6', '1982-01-10', 'United Kingdom', NULL, 'patricia-dantas', 20, '2023-12-28 18:21:28');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (98, 'Monika Jakubowska', 'Monika.jakvbowska@gmail.com', '$2b$10$SLfijoXJ4HA12oRC7WCyC.2bLjfh8cgIiIT3WxyUhuwuKUWVVfNrW', NULL, NULL, NULL, 'monika-jakubowska', 20, '2024-04-22 03:44:09');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (109, 'Marissa Tamayo', 'sangtamayo@gmail.com', '$2b$10$DhrQgjEcH8BsDdF8kVaOIeIzbi2BKoO1Jf17nMFia7dLnkot7Z7KC', NULL, NULL, NULL, 'marissa-tamayo', 20, '2024-05-19 10:14:03');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (125, 'Lachlan ', 'lachlanburr77@gmail.com', '$2b$10$8gOwzvuyQPLzcnFG.JYAUeFOlB2CDDQi.E/vhLOgLrt1CVqmRlY3G', NULL, NULL, NULL, 'lachlan', 20, '2024-06-01 10:54:14');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (173, 'John Dunn', 'dunn.john9@gmail.com', '$2b$10$ChevN/7DndKp29QFINbeHeNkfD8oe0w..wd8V8ZF.1mwCKawKTbt6', NULL, NULL, NULL, 'john-dunn', 20, '2024-06-28 10:53:14');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (191, 'Ali Ryder', 'ryder.alison@gmail.com', '$2b$10$Qo9MVzBtlLpfhmMjaPzQcehaS1sOXHIxWiQEV.n8fNs8MRT4Z0q0i', NULL, NULL, NULL, 'ali-ryder', 20, '2024-07-17 19:52:58');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (205, 'Coustie olivier', 'Olimentrol@gmail.com', '$2b$10$BBowwqeF6LzPmKyiZdOZleZTEk1VX5HylIMFEIK2BNQeDX9BnG70K', NULL, NULL, NULL, 'coustie-olivier', 20, '2024-09-24 12:50:44');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (212, 'Camden FC', 'Emmanuelfaboya@gmail.com', '$2b$10$EiPyvJuhdyIG8tPwUBrut.U/roeMjzaDNc/VF29DnbY8WfQoarEEe', NULL, NULL, 'user-1729518966004-39475.jpeg', 'camden-fc', 20, '2024-10-21 13:53:15');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (223, 'Doyin Adeleye', 'do.adeleye@gmail.com', '$2b$10$iiGCeU1UJXRj7UTE/.U7e.mzLjGlPmWibIf9iB87rAwlg2.SUDXN.', NULL, NULL, NULL, 'doyin-adeleye', 20, '2024-10-25 09:23:27');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (237, 'SLAMA Ali', 'ali.slama@free.fr', '$2b$10$z4ggdaV8i.dgSTZZp.cOgOYBE9zHqwcPQGgLEW82Xo3gfKfVGTIHO', NULL, NULL, NULL, 'slama-ali', 20, '2025-01-07 09:44:46');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (253, 'Michel Wittwer ', 'michelw56@gmail.com', '$2b$10$qeUClurX2xrT3BRbchdOAO8W9CP.0Siuo7WSKo6eDWdTq4I1tUXD.', NULL, NULL, NULL, 'michel-wittwer', 20, '2025-05-17 14:26:11');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (264, 'Michal Mysik', 'michal.mysik@gmail.com', '$2b$10$Ur23pjzU4mGA6oo2Ue0Zu.4zApOGXBecfDvT08oRf82KgNh8JjCtW', NULL, NULL, NULL, 'michal-mysik', 20, '2025-07-16 10:32:59');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (239, 'Yvan', 'ynajo5099@gmail.com', '$2b$10$juEDyvy7O7yig30PzSoPs.HbV3mcUSvmk5MN6.WIN8gIJEfZevVLO', NULL, NULL, NULL, 'yvan', 20, '2025-01-25 17:03:54');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (242, 'Lydia French', 'Lydiamfrench@gmail.com', '$2b$10$rGzYpKkVBREwNpx/MyMkFeGWtooWD/DFJWCqatkfMXvz8GkVURs5u', NULL, NULL, NULL, 'lydia-french', 20, '2025-02-17 15:07:27');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (248, 'DAVID', 'david.gallois@icloud.com', '$2b$10$CItwPCZFr0av1u9sWvCtw.6omKUtZNQ/G0dsDaGXp5MyuWuQt7r.K', NULL, NULL, NULL, 'david', 20, '2025-03-21 08:21:42');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (250, 'Petr Benda', 'petr.benda@centrum.cz', '$2b$10$yjIiitxWhlBhsj6fcSLAHOMZEYKp3viqHYOc3cb7usnYMBSiC87TO', NULL, NULL, NULL, 'petr-benda', 20, '2025-04-12 22:07:00');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (254, 'Geert en Sylvie', 'rozendom@gmail.com ', '$2b$10$y3Vbf7jSFj3JcVT9B7G1HOBIWW7R3IWdN1afH469WuZwIbDGU3//K', NULL, NULL, NULL, 'geert-en-sylvie', 20, '2025-05-21 12:40:45');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (262, 'Norbert ', 'Omgeving.6591@gmail.com', '$2b$10$svfbNvD9oLSx96TijGOY8u4YkFlNbFQZ6z65gHa1wZh.6g9/SfZdu', NULL, NULL, NULL, 'norbert', 20, '2025-07-05 13:52:24');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (266, 'Nadia', 'lfaboya12@gmail.com', '$2b$10$E3kLkcHAau50Z5yIvWgs2.B58VS87TkcIPJiGM1l4rPmHbT10jGoW', NULL, NULL, NULL, 'nadia', 20, '2025-08-13 19:56:21');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (45, 'Beth Old', 'bethany.old99@gmail.com', '$2b$10$2IoqmLNB8Y/owYUJlburM.4qeHJLjrKWj4TupgscqJ1UiTyNr/pp2', '1999-12-28', 'United Kingdom', NULL, 'beth-old', 20, '2023-11-18 14:40:26');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (75, 'Noura khattar', 'noura_khattar@yahoo.com', '$2b$10$OSyWMZm8Ur5HfNyFiS.MU.rixW5qE/ZiNdqNVLtLhMTz1a469d5UO', '1982-05-01', 'Canada', NULL, 'noura-khattar', 20, '2023-12-30 03:45:08');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (130, 'Rossy', 'rossydinda@gmail.com', '$2b$10$GnoMfvA1enfLzdJar4FPfu0Kv2yM8IJ60OX9FMO9ALl0cOvAEdkB.', NULL, NULL, 'user-1717972796749-78413.jpeg', 'rossy', 20, '2024-06-06 17:28:30');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (198, 'Mo Dickson', 'mo.dickson@internode.on.net', '$2b$10$lqT7Vob44hvDhorQqLaamuOKbpSMt2sPqvPSfiw7hR1nMR7vdh/46', NULL, NULL, NULL, 'mo-dickson', 20, '2024-08-27 09:00:53');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (230, 'Doyin A. ', 'Do.adeleye@gmail.com ', '$2b$10$EIUwAJbTKjIW2TGpvRAwmuIgnk03VsoHM7mY/qSMZdcAfp1Ak/zgm', NULL, NULL, NULL, 'doyin-a', 20, '2024-11-20 10:59:09');
INSERT INTO public.users (id, full_name, email, password, date_of_birth, country, image, slug, role, created_at) VALUES (243, 'Yiannis Arvanitis ', 'g.arvanitis14@gmail.com', '$2b$10$scqh1vgBtmVNbvosT.WOy.psKxaIVsWhAt5JRMN7o6TK/lFb/2mhG', NULL, NULL, NULL, 'yiannis-arvanitis', 20, '2025-03-04 12:57:38');


--
-- Data for Name: blog_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (3, 'What is WayzAway Social Network?', 'Have you ever wanted a place to record all the experiences and places you’ve visited and share those with only people you know and care about?

Would you like a safe place for your friends and family to share what they though of their weekend trip away, see the places they go and get ideas on what to do with your own free time?

WayzAway was started as a way to use social media to help people share their days out, trips and experiences with friends and families.

Use WazAway to record places or events you’ve experienced with your family, friends or on your own. You can also add places you plan to visit, invite your friends and wider family members to follow you and inspire each other with ideas for places to visit.

Wayzaway is a social network site that focuses on enhancing real life connections. There are no public profiles, no trending topics, your friend list built by email invite only and your page is only private to you and any friends you choose.

You can view the places your friends and families have visited and if you’re inspired to try it out yourself, add it to your favourites or to your wish list.

We believe WayzAway is how social media is meant to be. Practical, safe and helps you enjoy the connections with people you already know in real life.

Photo by Robert Collins on Unsplash
', 'blog-1698148891009-70301.jpg', 1, '2023-10-24 19:00:12');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (4, 'Website Logo, Home Page and Image Credits', 'Customer-journey icons created by Pixel perfect - Flaticon
Summer icons created by max.icons - Flaticon
Fun icons created by Freepik - Flaticon
Motorhome icons created by Smashicons - Flaticon
People icons created by Freepik - Flaticon

Photo by Scott Webb on Unsplash
Photo by Chris Richmond on Unsplash
Photo by Trust “Tru” Katsande on Unsplash

', 'blog-1698150319340-61808.jpg', 1, '2023-10-24 19:23:07');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (5, 'National Trust - A Great Idea for Family Days Out', 'National Trust Family Membership is currently £7.60 per month (1 adult + their children/grandchildren aged 17 or under) or £12.20 per month (2 adults living in the same household, their children/grandchildren aged 17 or under).

Or there is an option to purchase membership on an annual basis or as a gift. 

A child''s age is classed as 17 or under with National Trust which is brilliant for us as a family with two toddlers.

We have been National Trust members for about four years and have had the pleasure of visiting plenty of historic houses, learnt a lot about British history and had some wonderful days out.

The sites usually have amazing gardens, café’s and play areas for children. 

As I have already said, exploring the historic house is a great idea for a day out for the family, is highly educational and also interesting. The sites also make for great pictures.

We regularly use our National Trust membership and I think it''s genuinely one of the best value memberships you can buy.

If you''re looking for a membership where you can pay up front for the year or spread the cost via monthly payments which will include a never ending supply of activities and things to do (and is perfect for dog-owning families too), National Trust Membership could be for you. 
', 'blog-1699063213248-20985.jpeg', 1, '2023-11-04 09:00:14');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (6, 'Why You Should Embrace Travel Blogs', 'In a world that is becoming increasingly interconnected, the desire to explore new horizons has never been more prevalent. As the allure of travel continues to captivate individuals around the globe, the need for reliable and authentic information has become paramount. Enter travel blogs, the digital compass that guides wanderlust-stricken souls through uncharted territories. In this article, we delve into the reasons why people should embrace travel blogs as indispensable tools for planning and enhancing their travel experiences.

1.	Personalized Insights and Authentic Experiences:

Travel blogs are a treasure trove of personalized insights and authentic experiences. Unlike generic travel guides, blogs are often written by real travelers who share their unique encounters, hidden gems, and invaluable tips. This firsthand information provides a level of authenticity that guidebooks may lack, helping readers make more informed decisions about their travel destinations, accommodations, and activities.

2.	Real-Time Updates:

One of the significant advantages of travel blogs is the ability to provide real-time updates. Traditional travel guides may become outdated quickly, whereas blogs can be continuously updated to reflect the latest information, such as changes in local regulations, newly discovered attractions, or emerging trends. This ensures that travellers stay well-informed and prepared for any changes that may impact their journeys.

3.	Diverse Perspectives:

Travel blogs offer a diverse range of perspectives, allowing readers to explore destinations through the eyes of different individuals. Whether it''s a family adventure, solo exploration, or budget-friendly escapades, bloggers often share their unique viewpoints and experiences. This diversity enables travelers to find information that resonates with their specific interests, preferences, and travel styles.

4.	Interactive Communities:

Many travel blogs foster interactive communities where readers can engage in discussions, ask questions, and share their own experiences. This sense of community creates a supportive environment where travelers can seek advice, connect with like-minded individuals, and gain insights from a collective pool of knowledge. The exchange of ideas within these communities can enrich the travel planning process and contribute to a more enjoyable journey.

5.	Visual Inspiration:

Humans are visual beings, and travel blogs leverage this aspect by incorporating captivating photos and videos. These visual elements provide readers with a sneak peek into the beauty and vibrancy of a destination. High-quality images and engaging multimedia content help individuals envision their upcoming travels, igniting the spark of wanderlust and motivating them to explore new places.

6.	Budget-Friendly Tips:

Travel blogs are an excellent resource for budget-conscious travelers seeking tips on how to make the most of their money. Bloggers often share cost-saving strategies, hidden gems that won''t break the bank, and insights into affordable accommodation options. This information empowers individuals to plan budget-friendly trips without compromising on the quality of their experiences.

Conclusion:

In a world where the possibilities for exploration are endless, travel blogs serve as indispensable companions for those seeking to embark on unforgettable journeys. The combination of personalized insights, real-time updates, diverse perspectives, interactive communities, visual inspiration, and budget-friendly tips makes travel blogs an invaluable tool for both seasoned globetrotters and first-time adventurers. So, before you set off on your next adventure, let the digital compass of a travel blog guide you through the wondrous landscapes and cultural wonders that await.

Photo by Kalen Emsley on Unsplash


', 'blog-1701437301800-86177.jpeg', 1, '2023-12-01 20:28:23');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (7, 'Discovering Birmingham: A Guide to the Best Places to Visit in the UK''s Second City', 'Birmingham, often referred to as the "Heart of England," is a vibrant and dynamic city that seamlessly blends rich history with modern innovation. From its industrial heritage to its diverse cultural offerings, Birmingham has something for every type of traveler. In this guide, we''ll explore the best places to visit in this bustling metropolis, showcasing its unique charm and attractions.

1.	Birmingham Museum and Art Gallery (BMAG): Start your journey through Birmingham''s rich cultural tapestry by visiting the Birmingham Museum and Art Gallery. Located in the city center, BMAG houses an impressive collection of art, artifacts, and exhibitions spanning centuries. From pre-Raphaelite masterpieces to ancient artifacts, the museum provides a fascinating glimpse into Birmingham''s historical and artistic legacy.

2.	Cadbury World: A visit to Birmingham wouldn''t be complete without indulging in some chocolatey delights at Cadbury World. Perfect for families and chocolate enthusiasts alike, this interactive experience takes you through the history of Cadbury and offers a behind-the-scenes look at chocolate production. Don''t forget to savor the delicious treats along the way!

3.	Birmingham Botanical Gardens: Escape the urban hustle and bustle at the Birmingham Botanical Gardens, a serene oasis in the heart of the city. These stunning gardens feature a wide variety of plants, including tropical and subtropical specimens, making it an ideal spot for a leisurely stroll or a peaceful afternoon picnic.

4.	The Jewellery Quarter: For a taste of Birmingham''s artisanal heritage, head to the Jewellery Quarter. This historic area is home to a plethora of independent shops, galleries, and workshops where you can witness skilled craftsmen creating intricate jewelry. Explore the charming streets, visit the museums, and perhaps find a unique piece to take home.

5.	Birmingham Hippodrome: If you''re a fan of the performing arts, the Birmingham Hippodrome is a must-visit. As one of the busiest and most popular theaters in the UK, it hosts a diverse range of performances, from West End productions to contemporary dance and opera.

6.	Canals of Birmingham: Often called the "Venice of the North," Birmingham boasts an extensive network of canals. Take a leisurely canal boat ride or enjoy a stroll along the picturesque towpaths. The Gas Street Basin, at the heart of the canal network, is particularly charming with its waterside cafes and historic architecture.

7.	Library of Birmingham: For a modern architectural marvel, visit the Library of Birmingham. This iconic structure is not just a haven for book lovers but also offers stunning panoramic views of the city from its rooftop terrace. The library hosts events, exhibitions, and workshops, making it a cultural hub for locals and visitors alike.

8.	Sarehole Mill: Explore Birmingham''s connection to J.R.R. Tolkien at Sarehole Mill, believed to be the inspiration for the author''s vision of Hobbiton. This historic water mill, surrounded by picturesque countryside, provides a tranquil escape and a glimpse into Birmingham''s rural past.


Birmingham, with its diverse attractions and rich cultural offerings, is a city that captivates visitors from near and far. From its world-class museums to its serene botanical gardens, the city offers a perfect blend of history, culture, and modernity. Whether you''re interested in arts and history or simply want to enjoy the vibrant atmosphere, Birmingham is sure to leave you with lasting memories.


Photo by Brian Lewicki on Unsplash




', 'blog-1701779681716-91482.jpeg', 1, '2023-12-05 19:34:42');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (8, 'Navigating Adventures: The Benefits of Online Travel Journals', 'In the age of digital connectivity, the way we document and share our travel experiences has evolved. Online travel journals have become invaluable tools for globetrotters seeking to chronicle their journeys and share their stories with a wider audience. This article explores the myriad benefits of using online travel journals, illustrating why this modern approach is a fantastic idea for every avid traveller.

1.	Accessible Anytime, Anywhere: One of the primary advantages of online travel journals is their accessibility. Unlike traditional journals, which may be easily misplaced or damaged, digital platforms allow travellers to access their entries from anywhere with an internet connection. This convenience ensures that your travel memories are always at your fingertips, whether you''re reminiscing at home or sharing stories on the go.

2.	Multimedia Integration: Online travel journals provide the flexibility to incorporate various media elements seamlessly. From photos and videos to audio clips, travellers can enhance their narratives by capturing the sights, sounds, and emotions of their experiences. This multimedia approach not only enriches the storytelling process but also allows readers to immerse themselves more fully in the adventure.

3.	Community Engagement: Online travel journals foster a sense of community among like-minded individuals. By sharing your experiences on popular travel platforms or social media, you connect with fellow travellers, exchange tips, and inspire one another. The ability to receive feedback and engage in discussions adds a social dimension to your travel documentation, creating a network of supportive travel enthusiasts.

4.	Real-Time Updates for Loved Ones: For those who embark on journeys far from home, online travel journals serve as a real-time communication tool. Friends and family can follow your adventures instantly, providing them with peace of mind and a glimpse into your experiences. This instantaneous connection helps bridge the physical distance and ensures that your loved ones are part of your journey, even from afar.

5.	Searchable and Organized Content: Digital travel journals offer robust organizational tools, allowing travellers to categorize and search for specific entries effortlessly. This makes it easier to revisit particular moments, track recommendations, and compile valuable information for future trips. The searchable nature of online journals transforms them into dynamic, ever-growing travel resources.

6.	Privacy Controls: While sharing is a significant aspect of online travel journals, users maintain control over their privacy settings. Most platforms allow travellers to choose who can access their content, striking a balance between sharing experiences with a wider audience and maintaining personal boundaries.

Embracing the digital era has undoubtedly enhanced the way we document and share our travel adventures. Online travel journals offer a myriad of benefits, from accessibility and multimedia integration to community engagement and real-time updates for loved ones. As you embark on your next journey, consider weaving your travel tales into the digital fabric of online journals, ensuring that your experiences become enduring stories shared with the world.
', 'blog-1701780435001-2603.jpeg', 1, '2023-12-05 19:45:25');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (9, 'Embracing Solitude: Unique Solo Day Out Ideas for Self-Discovery', 'In a world bustling with activity and constant connectivity, spending quality time alone has become a rarity. However, carving out moments for solitary adventures can be an enriching and rejuvenating experience. Whether you''re seeking self-reflection, a break from routine, or simply embracing the joy of your own company, there are numerous unique solo day out ideas waiting to be explored.


1. Nature Retreat:

Escape the urban hustle and immerse yourself in the tranquility of nature. Explore a nearby national park, botanical garden, or nature reserve. Take a leisurely hike, pack a picnic, or simply find a quiet spot to connect with the natural world. The serene atmosphere provides the perfect backdrop for self-reflection and mindfulness.


2. Artistic Excursion:

Visit a local art gallery, museum, or sculpture park to indulge in the world of creativity. Allow the artwork to evoke emotions and contemplation. Take your time strolling through exhibits, absorbing the beauty and cultural richness on your own terms. Consider bringing a sketchpad or journal to capture your own thoughts inspired by the art.


3. Culinary Adventure:

Treat your taste buds to a solo culinary journey. Choose a cozy cafe, an exotic restaurant, or a food festival. Savor the flavors, try new dishes, and relish the experience of dining without distractions. You might even consider enrolling in a cooking class to enhance your culinary skills and bring the joy of a delicious homemade meal back home.


4. Mindful Retreat:

Engage in a day of self-care and mindfulness. Attend a yoga or meditation workshop, or embark on a solo retreat at a spa or wellness center. Pamper yourself with a massage, immerse in the healing properties of a hot spring, or simply unwind in a peaceful setting. Rediscover the importance of taking care of your mental and physical well-being.


5. Literary Expedition:

For book lovers, a day spent at a local library, bookstore, or literary cafe can be a haven of solace. Select a few books, find a quiet reading nook, and lose yourself in the world of literature. Alternatively, consider attending a book club meeting or literary event to connect with fellow enthusiasts and share your thoughts on a shared passion.


6. Photography Exploration:

Capture the world through your lens on a solo photography expedition. Wander through city streets, parks, or scenic landscapes, and document the beauty you encounter. Whether you''re an experienced photographer or a beginner, this creative endeavor allows you to see the world from a unique perspective and create lasting visual memories.


7. Educational Excursion:

Feed your curiosity by attending a workshop, lecture, or seminar on a topic that intrigues you. Whether it''s a history lecture, a science workshop, or a language class, engaging in intellectual pursuits on your own terms can be both fulfilling and empowering. Explore your interests and expand your knowledge base in a solo educational adventure.
Remember, the key to a successful solo day out is to embrace the
freedom and self-discovery that comes with being alone. Take the time to listen to your thoughts, appreciate your surroundings, and relish in the joy of being fully present in the moment.


8. Fitness Exploration:

Embark on a fitness adventure tailored to your interests. Try a new workout class, whether it''s yoga, dance, or martial arts. Alternatively, explore a scenic trail for a solo jog or hike. Physical activity not only contributes to your well-being but also provides an opportunity for self-reflection and personal growth.


9. Volunteer Experience:

Channel your energy into meaningful and altruistic endeavors by spending a day volunteering. Whether it''s at a local animal shelter, a community garden, or a soup kitchen, contributing to a cause you care about can be a rewarding and fulfilling experience. Connect with others through shared values and make a positive impact on your community.


10. Urban Exploration:

Become a tourist in your own city by exploring hidden gems and landmarks you may have overlooked. Visit a neighborhood you haven''t explored before, try a new cafe, or attend a local event. The sense of adventure and discovery in familiar surroundings can provide a fresh perspective and a renewed appreciation for your hometown.


11. Technology Detox Day:

Unplug and disconnect from the digital world for a day. Turn off your phone, resist the urge to check social media, and instead focus on connecting with yourself and your surroundings. Spend time in nature, engage in analog activities like journaling or sketching, and allow your mind to appreciate the simplicity of the offline experience.


12. Cultural Immersion:

Immerse yourself in the cultural richness of your community by attending a theater performance, live music concert, or cultural festival. Embrace the opportunity to appreciate the arts and connect with the vibrant tapestry of your local community. Being alone allows you to absorb the experience at your own pace and indulge in the cultural offerings that resonate with you.


As you venture into the world of solo exploration, remember that the goal is not just to be alone but to actively engage with yourself and your surroundings. Embrace the freedom to choose activities that resonate with your interests and passions. These unique solo day out ideas are designed to spark self-discovery, promote mindfulness, and foster a deeper connection with the world around you. So, step out, savor the solitude, and let each solo adventure be a celebration of your individuality and personal growth.

Photo by Myles Tan on Unsplash
', 'blog-1702385724250-50821.jpeg', 1, '2023-12-12 19:55:25');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (10, 'The Case for Private Social Media Platforms', 'In recent years, the landscape of social media has undergone significant changes, with users increasingly seeking platforms that prioritize privacy and security. The rise of private social media platforms has sparked a conversation about the benefits of a more guarded online environment. This article delves into the reasons why private social media is gaining traction, supported by research findings that shed light on the advantages of a more secure and controlled digital space.


1.	Enhanced Privacy and Security:

One of the primary advantages of private social media platforms is the heightened focus on user privacy and security. Research consistently demonstrates that individuals are becoming more concerned about the potential misuse of their personal data on mainstream social networks. Private platforms, with end-to-end encryption and strict privacy controls, provide users with a greater sense of control over their information.
According to a study by the Pew Research Center, 79% of adults in the United States are concerned about the way companies use their data. Private social media platforms, by encrypting communications and limiting data access, address these concerns and offer a more secure online experience.


2.	Curbing Cyberbullying and Harassment:

Research has shown a disturbing rise in cyberbullying and online harassment on open social media platforms. Private social media networks mitigate these issues by allowing users to carefully curate their connections, limiting interactions to a more trusted circle of friends and family. A study published in the Journal of Social and Personal Relationships found that individuals on private social media reported lower levels of online harassment compared to those on public platforms.


3.	Authentic Connections and Meaningful Engagement:

Private social media fosters a more intimate and authentic online experience. Research from the Journal of Communication Studies suggests that users on private platforms often engage in more meaningful conversations with close-knit groups. By creating a space where users feel comfortable sharing without the fear of judgment from a wider audience, private social media platforms encourage genuine connections.


4.	Personalized Content and Reduced Information Overload:

Public social media platforms are often criticized for overwhelming users with a constant stream of information. Private social media, on the other hand, emphasizes quality over quantity. Research conducted by the International Journal of Human-Computer Studies indicates that users on private platforms experience less information overload and are more likely to engage with content that is personally relevant.


Conclusion:

As research continues to highlight the drawbacks of public social media platforms, the appeal of private social networks becomes increasingly evident. Enhanced privacy, protection against cyberbullying, authentic connections, and personalized content are just a few of the advantages that make private social media a compelling choice for those seeking a more secure and meaningful online experience. As individuals become more conscious of their digital footprint, the shift towards private social media is likely to persist, reshaping the social media landscape in the years to come.


Photo by Prateek Katyal on Unsplash', 'blog-1702473668409-85345.jpeg', 1, '2023-12-13 20:21:09');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (11, 'Exploring the Idyllic Charm: A Review of the West Midlands'' Most Popular Countryside Destinations', 'Nestled in the heart of the United Kingdom, the West Midlands offers a delightful tapestry of picturesque landscapes, quaint villages, and serene countryside getaways. For those seeking a peaceful escape from bustling urban life, the region boasts an array of charming destinations. In this article, we will explore and review some of the most popular countryside places to visit in the West Midlands, each offering a unique blend of natural beauty, cultural richness, and tranquility.


1.	Malvern Hills: A Panoramic Paradise

The Malvern Hills, designated as an Area of Outstanding Natural Beauty, provide a stunning backdrop for nature enthusiasts and hikers alike. With sprawling vistas that extend across the Severn Valley and charming market towns like Great Malvern, visitors can enjoy a perfect blend of outdoor activities and relaxation. The Worcestershire Beacon, the highest point of the hills, rewards hikers with breathtaking panoramic views.


2.	Cotswolds: Timeless Beauty and Quintessential Charm

Venture into the northeastern corner of the West Midlands, and you''ll find yourself in the enchanting Cotswolds. Famous for its honey-colored limestone villages, rolling hills, and meandering streams, the Cotswolds offer a quintessentially English countryside experience. Bibury, with its iconic Arlington Row cottages, and Bourton-on-the-Water, known as the "Venice of the Cotswolds," are must-visit gems.


3.	Stratford-upon-Avon: Shakespearean Splendor

While renowned as the birthplace of William Shakespeare, Stratford-upon-Avon also boasts scenic riverside views and beautiful parks. Take a stroll along the banks of the River Avon, explore the manicured gardens of Anne Hathaway''s Cottage, and soak in the cultural ambiance of the Royal Shakespeare Theatre. The town effortlessly combines literary history with the tranquility of the countryside.


4.	Dudley Canal and Tunnel Trust: Hidden Waterway Wonders

For a unique countryside experience, head to Dudley and explore the fascinating Dudley Canal and Tunnel Trust. Take a boat trip through limestone caverns and tunnels, learning about the region''s industrial history. The limestone mines and Dudley Canal provide a distinctive countryside setting, offering visitors an intriguing blend of nature and heritage.


5.	The Long Mynd: Shropshire''s Hiker''s Haven

Venturing into Shropshire, the Long Mynd offers a haven for hikers and lovers of rugged landscapes. This expansive moorland, crisscrossed by walking trails, provides breathtaking views of the Shropshire Hills. Carding Mill Valley, with its babbling streams and heather-clad hills, is a gateway to this natural wonder.


Conclusion:

The West Midlands'' countryside unveils a tapestry of diverse landscapes, from the panoramic views of the Malvern Hills to the timeless charm of the Cotswolds and the cultural richness of Stratford-upon-Avon. Whether you''re a hiker, history enthusiast, or simply seeking tranquility, the West Midlands'' countryside destinations offer a plethora of options for an unforgettable retreat into nature''s embrace. Each location we''ve explored adds a unique flavor to the region''s rural allure, inviting visitors to experience the idyllic charm of the West Midlands.


Photo by Illiya Vjestica on Unsplash', 'blog-1702473976477-93383.jpeg', 1, '2023-12-13 20:26:17');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (12, '"Nature''s Symphony: A Review of the Twelve Most Beautiful Parks in the West Midlands"', 'The West Midlands, a region pulsating with urban energy, also houses a collection of breathtaking parks that serve as verdant sanctuaries for residents and visitors alike. From meticulously manicured gardens to sprawling expanses of natural beauty, these twelve parks showcase the diverse landscapes and recreational havens that the West Midlands has to offer.


1.	Cannon Hill Park (Birmingham): A Green Oasis in the City

Cannon Hill Park, nestled in the heart of Birmingham, is a verdant haven boasting pristine lakes, charming walking paths, and vibrant floral displays. With its boating lake and family-friendly attractions, this park seamlessly combines natural beauty with recreational opportunities.


2.	Warley Woods (Smethwick): Tranquility in the Urban Landscape

Warley Woods, a sprawling park in Smethwick, offers a peaceful retreat surrounded by ancient woodlands and open meadows. With its well-maintained trails and historic charm, this park provides a serene escape from the hustle and bustle of city life.


3.	Sandwell Valley Country Park (West Bromwich): Nature and Heritage Intertwined

Sandwell Valley Country Park seamlessly blends natural beauty with historical significance. Home to Sandwell Priory and Forge Mill Farm, this park invites visitors to explore its scenic trails while immersing themselves in the region''s rich heritage.


4.	Kings Heath Park (Birmingham): A Botanical Gem

For flora enthusiasts, Kings Heath Park is a botanical gem featuring a Victorian conservatory, a sensory garden, and a stunning array of plants. The park''s meticulous landscaping and diverse plant life make it a visual feast for nature lovers.


5.	Walsall Arboretum: A Riverside Oasis

Walsall Arboretum, situated along the banks of the Hatherton Canal, offers a tranquil escape with its ornamental lake, boating facilities, and lush greenery. The park''s carefully designed landscapes make it a popular destination for both relaxation and recreation.


6.	Sutton Park (Sutton Coldfield): A Wilderness Retreat

Sutton Park, one of the largest urban parks in Europe, spans over 2,000 acres of woodlands, heathlands, and wetlands. With its expansive landscapes and numerous lakes, Sutton Park provides a wilderness retreat just a stone''s throw from the city.


7.	Edgbaston Reservoir (Birmingham): A Serene Waterfront Escape

Edgbaston Reservoir offers a peaceful waterfront escape surrounded by greenery. The reservoir''s walking and cycling paths provide panoramic views of the city skyline, creating a serene atmosphere for those seeking a contemplative outdoor experience.


8.	East Park (Wolverhampton): Victorian Elegance Amidst Nature

East Park, an exemplar of Victorian park design, features ornamental gardens, a boating lake, and a miniature railway. The park''s elegant landscaping and diverse recreational facilities make it a cherished destination for families and nature enthusiasts.


9.	Bantock Park (Wolverhampton): A Blend of Nature and Art

Bantock Park, surrounding the historic Bantock House, seamlessly blends nature with art and culture. The park''s formal gardens, woodlands, and vibrant flowerbeds provide a scenic backdrop for exploring the museum and its art collections.


10.	Lickey Hills Country Park (Birmingham): A Hiker''s Haven

Lickey Hills Country Park, known for its panoramic views of the surrounding countryside, offers a haven for hikers and nature enthusiasts. With its diverse habitats, including heathlands and ancient woodlands, the park provides a rich tapestry of natural wonders.


11.	Cofton Park (Birmingham): A Green Jewel in Longbridge

Cofton Park, situated in the Longbridge area, features expansive green spaces, woodlands, and a beautiful lake. The park''s well-maintained paths and play areas make it a popular destination for families and individuals seeking a peaceful outdoor experience.


12.	Calderstones Park (Liverpool, but close to West Midlands): A Botanical Paradise

Just a short distance away in Liverpool, Calderstones Park beckons with its stunning botanical gardens, historical features, and the Allerton Oak, a thousand-year-old tree. The park''s horticultural beauty and cultural significance make it a noteworthy destination for nature lovers.


Conclusion:

The West Midlands'' parks are not merely green spaces; they are living canvases that showcase the region''s commitment to preserving and celebrating nature. From the urban elegance of Cannon Hill Park to the wilderness charm of Sutton Park, each of these twelve parks contributes to the symphony of natural beauty that defines the West Midlands. Whether you seek a tranquil retreat, a botanical paradise, or a wilderness adventure, these parks offer a diverse range of experiences for everyone to enjoy.
', 'blog-1702474688565-92655.jpeg', 1, '2023-12-13 20:38:09');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (13, 'The Best Indoor Family-Friendly Activities in London', 'London, a city bursting with cultural richness and historical landmarks, also provides a plethora of indoor activities that promise a world of excitement and exploration for families. Whether the weather outside is dreary or you simply prefer indoor adventures, the capital city has something for everyone. In this article, we''ll explore and review the best indoor activities for families in London, ensuring a memorable experience for all.


1.	The Science Museum: Unleashing Curiosity

Located in the heart of South Kensington, the Science Museum is a treasure trove of interactive exhibits, mind-boggling experiments, and educational fun. Families can explore everything from space travel to the wonders of human biology, making it an ideal destination for curious minds of all ages.


2.	The Natural History Museum: A Jurassic Adventure

Another gem in South Kensington, the Natural History Museum invites families to embark on a journey through the wonders of the natural world. From towering dinosaur skeletons to dazzling gemstones, this museum combines education with awe-inspiring exhibits that captivate both young and old.


3.	KidZania: Where Imagination Takes Flight

Nestled within the Westfield Shopping Centre in Shepherd''s Bush, KidZania offers a unique and immersive experience for children. This child-sized city allows young ones to try out various professions, from firefighting to broadcasting, fostering creativity and a sense of independence in a safe and controlled environment.


4.	SEA LIFE London Aquarium: Dive into Ocean Wonders

Situated on the South Bank of the Thames, the SEA LIFE London Aquarium provides a mesmerizing underwater adventure. Families can marvel at majestic sharks, graceful rays, and playful penguins in the aquarium''s diverse exhibits, making it a fantastic destination for marine enthusiasts.


5.	Hamleys: Toy Wonderland in Regent Street

For a whimsical indoor experience, Hamleys in Regent Street is a toy wonderland that sparks joy for visitors of all ages. With multiple floors filled with games, dolls, and interactive demonstrations, this iconic toy store offers a magical journey through the world of play.


6.	Shrek''s Adventure!: A Fairy Tale Extravaganza

Located on the South Bank, Shrek''s Adventure! takes families on a hilarious and immersive journey through the kingdom of Far Far Away. Interactive shows, captivating storytelling, and beloved characters make this attraction a hit for families seeking a dose of fairy-tale magic.


7.	The British Museum: Time Travel Through History

Journey through time at The British Museum, located in Bloomsbury. With its vast collection of artifacts from around the world, this museum offers a fascinating glimpse into the history of human civilization. The Rosetta Stone, the Egyptian mummies, and the Elgin Marbles are just a few highlights awaiting exploration.


8.	Clip ''n Climb Chelsea: Scaling New Heights

For active families, Clip ''n Climb Chelsea provides a thrilling indoor rock-climbing experience. With colorful climbing walls and various challenges suitable for different skill levels, this venue offers a physically engaging and adventurous outing for the entire family.


9.	The Postal Museum: A Journey Below the Streets

Delve into the history of communication at The Postal Museum, which includes a unique Mail Rail ride beneath the streets of London. Families can explore interactive exhibits, discover the evolution of postal services, and enjoy the subterranean adventure on the miniature train.


10.	The Shard''s View from The Shard: London from Above

For a breathtaking indoor experience, head to The Shard and ascend to its observation deck, The View from The Shard. With panoramic views of London''s skyline, this attraction provides a unique perspective on the city''s landmarks, making it a memorable outing for families.


Conclusion:

From the wonders of science to the depths of the ocean, London offers a myriad of indoor activities that cater to the diverse interests of families. The city''s museums, interactive attractions, and immersive experiences create lasting memories while providing educational and entertaining content for visitors of all ages. The next time you find yourself in London, embrace the excitement of indoor adventures with these family-friendly destinations.


Photo by David Henderson on Unsplash
', 'blog-1702475085752-67856.jpeg', 1, '2023-12-13 20:44:47');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (14, '"Cultural Treasures: A Review of the Best Museums in the West Midlands, UK"', 'The West Midlands, a region steeped in history and innovation, boasts an array of museums that showcase the rich tapestry of its cultural heritage. From industrial revolution marvels to world-class art collections, these institutions offer immersive experiences for locals and visitors alike. In this article, we''ll explore and review the best museums in the West Midlands, inviting you to delve into the fascinating stories and artifacts that make this region truly unique.


1.	Birmingham Museum and Art Gallery (BMAG): A Cultural Oasis

Nestled in the heart of Birmingham, the Birmingham Museum and Art Gallery is a cultural oasis that seamlessly blends art and history. With diverse collections ranging from Pre-Raphaelite masterpieces to ancient artifacts, BMAG provides a comprehensive journey through time and creativity.


2.	Ironbridge Gorge Museums: Birthplace of the Industrial Revolution

Located in Telford, the Ironbridge Gorge Museums collectively form a UNESCO World Heritage site, celebrating the birthplace of the Industrial Revolution. Visitors can explore the Iron Bridge itself, as well as the various museums, including the Museum of Iron and Blists Hill Victorian Town, offering an immersive experience of life in the 19th century.


3.	Herbert Art Gallery and Museum (Coventry): Local History and Contemporary Art

The Herbert Art Gallery and Museum in Coventry is a dynamic institution that seamlessly combines local history with contemporary art. From medieval artifacts to thought-provoking exhibitions, this museum provides a diverse cultural experience for all ages.


4.	National Motorcycle Museum: Revving Up History

For enthusiasts of two-wheeled marvels, the National Motorcycle Museum in Solihull is a must-visit destination. With an extensive collection of vintage and modern motorcycles, this museum offers a thrilling journey through the evolution of motorized two-wheelers.


5.	Thinktank, Birmingham Science Museum: Inspiring Curiosity

Situated in Millennium Point, Thinktank is Birmingham''s award-winning science museum. Catering to curious minds of all ages, Thinktank features interactive exhibits, fascinating displays, and live science demonstrations, making it an engaging and educational experience for families.


6.	Coventry Transport Museum: Wheels of Progress

The Coventry Transport Museum is a haven for automotive enthusiasts, showcasing the city''s significant contributions to the world of transportation. From bicycles to iconic cars, this museum offers a captivating exploration of Coventry''s role in shaping the history of mobility.


7.	Lunt Roman Fort: A Glimpse into Roman Britain

Step back in time at Lunt Roman Fort in Baginton, where visitors can experience life in Roman Britain. The reconstructed fort provides an immersive journey into the past, complete with interactive exhibits, demonstrations, and living history events.


8.	Sarehole Mill (Birmingham): Tolkien''s Inspiration

For fans of J.R.R. Tolkien, Sarehole Mill in Birmingham holds a special significance. The historic water mill, which inspired scenes in "The Hobbit," offers a charming glimpse into the author''s childhood and the rural landscape that influenced his works.


9.	Compton Verney Art Gallery and Park: Stately Splendor

Nestled in Warwickshire, Compton Verney is a stately home turned art gallery surrounded by picturesque parkland. The gallery hosts a diverse collection of European paintings, sculptures, and decorative arts, set against the backdrop of Capability Brown-designed grounds.


10.	Black Country Living Museum: Living History

Immerse yourself in the sights, sounds, and smells of the past at the Black Country Living Museum in Dudley. This open-air museum brings history to life with reconstructed buildings, costumed interpreters, and working industrial exhibits, providing a vivid experience of life in the Black Country during the 19th and early 20th centuries.


Conclusion:

The West Midlands'' museums stand as cultural beacons, offering a kaleidoscope of experiences that reflect the region''s diverse history and contributions to art, industry, and innovation. Whether you''re delving into the industrial revolution''s legacy, exploring artistic masterpieces, or stepping into the pages of literary history, the museums of the West Midlands provide enriching and memorable journeys through time and culture. Plan your visits and uncover the treasures that make these institutions true gems in the heart of England.
', 'blog-1702475321647-82486.jpeg', 1, '2023-12-13 20:48:42');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (15, 'Exploring Boundless Adventures: A Guide to Maximizing Online Journals for Family Days Out', 'In the age of technology, planning and executing memorable family days out has evolved. Online journals have become invaluable tools for families seeking new and exciting adventures. From researching destinations to documenting cherished moments, the digital landscape has revolutionized the way we plan and experience family outings. In this article, we''ll delve into the myriad ways online journals can enhance your family days out, providing practical tips and insights for a seamless and enjoyable experience.


Researching Destinations:

One of the primary benefits of online journals is the wealth of information they provide about various destinations. Families can explore firsthand experiences, reviews, and recommendations shared by fellow adventurers. Whether you''re interested in theme parks, nature reserves, or historical sites, online journals offer a plethora of insights to help you make informed decisions about your family day out.

Recommendation: Before settling on a destination, read multiple reviews to gain a well-rounded perspective. Look for journals that highlight family-friendly features, accessibility, and any potential challenges that might affect your day.


Planning Itinerary:

Online journals serve as excellent resources for crafting a detailed itinerary for your family day out. Engage with narratives of other families who have visited the same location and gather insights into the best routes, must-see attractions, and optimal times for specific activities. Create a personalized plan that caters to your family''s preferences and interests.

Recommendation: Use online journals to find hidden gems and off-the-beaten-path attractions that might not be well-known but could add a unique touch to your itinerary.



Budgeting and Discounts:

Families often seek cost-effective ways to enjoy a day out together. Online journals can guide you in managing your budget wisely by providing information on ticket prices, special discounts, and promotions. Many bloggers share tips on how to save money on various aspects of a family day out, allowing you to make the most of your resources.

Recommendation: Keep an eye out for exclusive online deals and discounts mentioned in journals, and consider subscribing to newsletters or following social media accounts of family travel bloggers for real-time updates on special offers.


Packing Essentials:

Preparing for a family day out involves meticulous packing to ensure everyone''s comfort and safety. Online journals often feature comprehensive packing lists based on personal experiences. From sunscreen and snacks to spare clothing and first aid kits, these lists can serve as valuable guides to streamline your packing process.

Recommendation: Take note of specific items mentioned by experienced families in their journals, and tailor your packing list to suit your family''s needs and the unique requirements of the chosen destination.


Capturing Memories:

The beauty of family days out lies in the memories created and cherished for years to come. Online journals offer inspiration for creative ways to capture these moments. From photography tips to journaling techniques, experienced families share their methods for preserving the magic of the day.

Recommendation: Consider creating a digital or physical scrapbook to compile photos, ticket stubs, and handwritten notes from each family day out. This personalized keepsake will be a treasure trove of memories.


Navigating Challenges:

Despite meticulous planning, unforeseen challenges may arise during a family day out. Online journals provide a platform for families to share their experiences overcoming obstacles, offering valuable insights into problem-solving and adaptability.

Recommendation: Read about challenges faced by others in online journals and take note of the strategies they employed to turn setbacks into opportunities for bonding and learning.


Sharing Your Experience:

Once your family day out is complete, contribute to the online community by sharing your own experiences through an online journal or social media. Your insights may help other families plan their adventures, fostering a sense of connection within the online family travel community.

Recommendation: Include practical tips, recommendations, and personal anecdotes in your journal to provide a comprehensive overview of your family day out. Engage with readers by responding to comments and questions to build a supportive network.


Conclusion:

Embracing the power of online journals can transform your family days out from routine to remarkable. By tapping into the collective wisdom of fellow adventurers, you can make informed decisions, overcome challenges, and create lasting memories with your loved ones. So, embark on your next family adventure with the guidance of online journals, and let the digital realm enhance your real-world experiences.


Photo by Adam Sherez on Unsplash


', 'blog-1704157834204-18804.jpeg', 1, '2024-01-02 08:10:35');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (16, 'The Power of Privacy: Unraveling the Popularity of Private Lifestyle Journals', 'In a world that often thrives on public sharing and social media oversharing, the popularity of private lifestyle journals stands as a testament to the enduring allure of personal introspection and the need for a sacred space of self-expression. These private journals, often tucked away from the prying eyes of the public, provide individuals with a sanctuary for genuine reflection, raw emotion, and unfiltered thoughts. In this article, we will delve into the intricate reasons behind the rising popularity of private lifestyle journals, exploring the psychological, emotional, and social factors that contribute to their widespread appeal.


Authentic Self-Expression

One of the primary draws of private lifestyle journals lies in their capacity to facilitate authentic self-expression without the constraints of external judgment. In a society where curated online personas and carefully crafted images prevail, private journals offer a space where individuals can be unabashedly themselves. This authentic self-expression allows for a deeper exploration of thoughts, emotions, and experiences, free from the pressure of societal expectations.
Private journals become a canvas for individuals to express their truest selves, acknowledging the complexities and nuances that may not be readily shared in public spaces. The freedom to be vulnerable without fear of judgment fosters a sense of authenticity that contributes significantly to the popularity of private lifestyle journals.


Emotional Catharsis and Therapeutic Benefits

The act of journaling has long been recognized as a therapeutic tool, and private lifestyle journals, in particular, provide an intimate avenue for emotional catharsis. Writing down one''s thoughts and feelings can be a cathartic release, allowing individuals to process and make sense of their emotions. The private nature of these journals ensures that this emotional release remains a personal and confidential experience.
The popularity of private lifestyle journals is closely tied to their role in mental and emotional well-being. The act of journaling serves as a form of self-therapy, enabling individuals to navigate the complexities of their emotions, find clarity, and develop a deeper understanding of themselves. The confidential nature of private journals fosters a safe space for this emotional exploration, contributing to their widespread appeal.


Unfiltered Reflection and Growth

Private lifestyle journals offer a dedicated space for unfiltered self-reflection, allowing individuals to confront their thoughts, fears, and aspirations honestly. The absence of an external audience enables a more genuine exploration of personal growth, as individuals can document their evolving perspectives without the pressure of external expectations.
The private nature of these journals allows individuals to reflect on their journey, track personal development, and set genuine goals without the influence of external validation. The raw, unfiltered nature of this self-reflection contributes to a more authentic and meaningful personal narrative, fostering a sense of self-awareness and growth.


Enhanced Privacy in a Digital Age

In an era where digital footprints and online exposure are constant concerns, private lifestyle journals provide a tangible, offline refuge. With growing awareness of data privacy and the potential pitfalls of oversharing online, individuals are turning to private journals as a secure and confidential means of self-expression.
Traditional paper journals, stored in a physical space, offer a level of privacy that digital platforms sometimes struggle to provide. The tangible nature of a private journal eliminates concerns about hacking, data breaches, or unintended sharing. The sense of control over the privacy of one''s thoughts and experiences contributes significantly to the popularity of private lifestyle journals in an increasingly digital age.


Intimate Connection with Thoughts and Memories

Private lifestyle journals serve as tangible repositories of thoughts, memories, and experiences. The act of physically writing down one''s reflections creates an intimate connection between the individual and their thoughts. The tactile experience of putting pen to paper enhances the emotional resonance of the journaling process, making it a more immersive and personal experience.
These private journals become archives of personal history, capturing the essence of specific moments, emotions, and insights. The tangible connection with the journal fosters a deeper relationship with one''s thoughts and memories, creating a cherished and tangible record of personal experiences.


Freedom from External Validation

Public sharing often comes with an inherent desire for external validation, likes, and comments. Private lifestyle journals, by contrast, offer freedom from the pressure to seek approval or validation from others. The act of journaling becomes a solely personal endeavor, driven by the individual''s need for self-reflection and expression rather than external recognition.
The absence of an audience allows individuals to explore and embrace aspects of themselves that may not align with societal norms or expectations. This freedom from external validation fosters a sense of liberation, encouraging individuals to delve into their truest selves without the constraints of external judgments.


Uninterrupted Honesty and Openness

Private lifestyle journals thrive on uninterrupted honesty and openness. The absence of an external audience means individuals can be completely candid about their thoughts, feelings, and experiences. This uninhibited self-expression allows for a level of openness that may be challenging to achieve in public spaces, where considerations of societal norms or the expectations of others can influence the narrative.
The private nature of these journals encourages individuals to confront their vulnerabilities, embrace imperfections, and express themselves without filters. This unapologetic honesty contributes to a more genuine and meaningful documentation of personal experiences.


Unstructured Creativity

While some individuals enjoy the structure of organized, themed journals, private lifestyle journals often provide a canvas for unstructured creativity. The absence of an external audience or predefined expectations allows individuals to explore their creativity freely. Whether through free-form writing, doodling, or incorporating mixed media, private journals become a playground for uninhibited artistic expression.
The unstructured nature of these journals encourages experimentation, fostering a sense of creative freedom that may be stifled in more curated or public spaces. The emphasis on personal satisfaction rather than external reception enhances the joy of creative expression within the private realm.


Conclusion

In conclusion, the popularity of private lifestyle journals can be attributed to a myriad of factors that resonate with the human need for genuine self-expression, emotional catharsis, and personal growth. The private nature of these journals offers a refuge from the external pressures of public sharing, providing individuals with an intimate space for unfiltered reflection and creativity.
As the digital age continues to shape the way we communicate and express ourselves, private lifestyle journals stand as a counterbalance, emphasizing the importance of personal privacy and the tangible, offline experience of self-reflection. In a world that often clamors for attention and validation, private lifestyle journals offer a quiet sanctuary for individuals seeking authenticity, emotional release, and the freedom to explore their truest selves without reservation.


Photo by Tim Graf on Unsplash', 'blog-1705449295868-43783.jpeg', 1, '2024-01-17 06:54:56');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (17, ' Exploring Europe in Spring: Top Destinations to Awaken Your Wanderlust', 'As winter''s chill fades away and nature begins to bloom, Europe emerges as a captivating destination, offering a myriad of experiences that celebrate the arrival of spring. From vibrant festivals to scenic landscapes, Europe beckons travellers to embark on unforgettable adventures during this enchanting season. Whether you''re seeking cultural immersion, outdoor escapades, or simply a rejuvenating getaway, Europe has something to offer for every type of traveller. Here, we explore some of the best places to visit in Europe during spring, where you can revel in the beauty of the season and create cherished memories that will last a lifetime.

1. Amsterdam, Netherlands

Renowned for its picturesque canals and vibrant tulip fields, Amsterdam is a quintessential spring destination in Europe. In April, the city comes alive with the blooming of millions of tulips, daffodils, and hyacinths, painting the landscape with a kaleidoscope of colours. Visitors can immerse themselves in the world of flowers at the famous Keukenhof Gardens, where they can stroll through intricately designed flower displays and witness the beauty of Dutch horticulture. Additionally, springtime in Amsterdam coincides with King''s Day, a national holiday celebrated with lively street parties, concerts, and flea markets, offering a glimpse into Dutch culture and traditions.

2. Provence, France

Famed for its idyllic countryside, fragrant lavender fields, and charming hilltop villages, Provence is a captivating destination to explore in spring. As the weather warms up, the region bursts into bloom, with fields of lavender, sunflowers, and poppies carpeting the landscape in vibrant hues. Visitors can embark on scenic drives through the countryside, stopping at picturesque villages such as Gordes, Roussillon, and Saint-Rémy-de-Provence to soak in the charm of rural life. Additionally, spring is the perfect time to indulge in Provence''s world-renowned cuisine, with fresh produce such as strawberries, asparagus, and artichokes in abundance at local markets and restaurants.

3. Barcelona, Spain

With its sunny weather, stunning architecture, and lively atmosphere, Barcelona is an enticing destination year-round, but it truly comes alive in spring. As the city shakes off the winter chill, outdoor cafes and tapas bars spill onto the streets, inviting visitors to soak up the Mediterranean sunshine. Springtime in Barcelona also coincides with several cultural events and festivals, including the iconic Sant Jordi''s Day, celebrated on April 23rd, when the city is adorned with roses and book stalls line the streets in honour of love and literature. Visitors can also explore the city''s architectural gems, such as the iconic Sagrada Familia and Park Güell, without the crowds that flock during the peak summer months.

4. Tuscany, Italy

Renowned for its rolling hills, vineyards, and historic towns, Tuscany is a dream destination for travellers seeking tranquillity and natural beauty. In spring, the Tuscan countryside bursts into life with lush green landscapes dotted with colourful wildflowers and blossoming trees. Visitors can embark on leisurely drives through the Val d''Orcia region, stopping at charming towns like Montepulciano, Pienza, and San Gimignano to explore ancient cobblestone streets and savour authentic Italian cuisine. Additionally, spring is an ideal time to visit Tuscany''s world-renowned wineries, where visitors can indulge in wine tastings amidst the picturesque vineyards.

5. Prague, Czech Republic

Steeped in history and architectural splendour, Prague captivates visitors with its fairy-tale charm and medieval beauty. In spring, as the city shakes off the winter frost, Prague''s historic streets and squares come alive with colour and vitality. Visitors can stroll across the iconic Charles Bridge, framed by blooming cherry blossoms, and explore the picturesque alleys of the Prague Castle complex. Springtime in Prague also brings an array of cultural events and festivals, including the Prague Spring International Music Festival, which showcases world-class classical music performances in venues across the city. With fewer crowds and mild weather, spring is the perfect time to discover the enchanting allure of the Czech capital.

6. Santorini, Greece

Famed for its breathtaking sunsets, whitewashed villages, and crystal-clear waters, Santorini is a paradise destination that truly shines in spring. As the island awakens from its winter slumber, vibrant wildflowers carpet the hillsides, and the aroma of blooming bougainvillea fills the air. Visitors can explore the iconic cliffside villages of Oia, Fira, and Imerovigli, with their charming narrow streets and panoramic views of the Aegean Sea. Spring also marks the beginning of the island''s beach season, offering opportunities for swimming, sunbathing, and water sports on Santorini''s pristine beaches. With fewer tourists and pleasant weather, spring is an ideal time to experience the magic of this Greek island gem.

7. The Cotswolds, England

Nestled in the heart of rural England, the Cotswolds is a picture-perfect destination renowned for its quintessential English countryside, charming villages, and historic landmarks. In spring, as the landscape awakens from its winter slumber, the Cotswolds are blanketed in a tapestry of blooming wildflowers, lush green meadows, and budding trees. Visitors can embark on scenic walks along the Cotswold Way, a long-distance footpath that traverses rolling hills, picturesque valleys, and ancient woodlands. Spring also brings a plethora of seasonal events and activities, including garden tours, village fetes, and agricultural shows, providing visitors with a glimpse into traditional English life.

Conclusion

From the colourful tulip fields of Amsterdam to the sun-drenched shores of Santorini, Europe offers a wealth of enchanting destinations to explore during the spring season. Whether you''re seeking cultural immersion, outdoor adventures, or simply a tranquil retreat amidst nature, Europe''s diverse landscapes and vibrant cities are sure to captivate your senses and awaken your wanderlust. So pack your bags, embark on a journey of discovery, and experience the magic of Europe in springtime.

Photo by Myron Mott on Unsplash', 'blog-1711576872799-64412.jpeg', 1, '2024-03-28 05:01:13');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (18, 'Landing Page Image Credits', 'Friends, Family
Photo by Tyler Nix on Unsplash

Family walking on dirt road during daytime
Photo by Naré Gevorgyan on Unsplash

Group of people standing on beach during daytime
Photo by Jimmy Conover on Unsplash
', NULL, 1, '2024-04-09 03:48:47');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (19, '10 Creative Ideas for Unforgettable Children''s Birthday Parties in Birmingham, UK', 'Planning a children''s birthday party can be both thrilling and overwhelming. In Birmingham, UK, there''s a wealth of options to create an unforgettable celebration for your little one. From traditional favourites to unique experiences, there''s something for every child''s interest and every parent''s budget. In this article, we''ll explore ten creative ideas to make your child''s birthday party a hit in Birmingham.

Themed Parties at Birmingham Museums:
Birmingham is home to various museums offering themed birthday parties. Choose from themes like dinosaurs at the Lapworth Museum of Geology or space exploration at Thinktank Birmingham Science Museum. These venues provide interactive experiences and educational activities, often including a guided exhibit tour. It''s not only fun but also enriching for the young minds.

Outdoor Adventure at Lickey Hills Country Park:
For the adventurous souls, hosting a party at Lickey Hills Country Park promises a day filled with excitement. Activities such as nature trails, orienteering, and den building can keep the children engaged and active. Pack a picnic and enjoy the beautiful natural surroundings while the kids burn off some energy.

Creative Workshops at Birmingham Art Gallery:
Birmingham Art Gallery offers creative workshops that are perfect for budding artists. Let the children unleash their creativity through painting, pottery, or sculpture. Experienced instructors guide them through the process, and each child gets to take home their masterpiece—a memorable and artistic way to celebrate.

Sports Extravaganza at a Local Sports Centre:
Birmingham boasts numerous sports centres offering birthday party packages tailored to energetic kids. Football, gymnastics, and swimming are sports for every interest. These venues typically provide equipment, coaches, and sometimes even a mini-tournament, ensuring a day packed with fun and healthy competition.

Magical Theatre Experience at Birmingham Hippodrome:
Treat your child to a magical theatre experience at Birmingham Hippodrome. Many theatres offer special birthday packages, including tickets to a family-friendly show, backstage tours, and even a meet-and-greet with the cast. It''s a chance for kids to immerse themselves in the performing arts world and create lasting memories.

Animal Encounters at Birmingham Wildlife Conservation Park:
If your child loves animals, hosting a birthday party at Birmingham Wildlife Conservation Park is a fantastic choice. The park is home to various fascinating creatures, from meerkats to lemurs to reptiles. Many venues offer guided tours, animal feeding sessions, and hands-on experiences, making it an educational and entertaining option.

Culinary Adventures with Cooking Classes:
For little chefs, cooking classes can be a delightful way to celebrate their special day. Many cooking schools in Birmingham offer children''s birthday party packages where they can learn to bake cupcakes, decorate cookies, or make their own pizzas. It''s a deliciously fun experience that leaves everyone with a tasty treat to enjoy.

Outdoor Picnic and Games at Cannon Hill Park:
Cannon Hill Park provides a picturesque setting for a relaxed outdoor birthday party. Pack a picnic basket with sandwiches, snacks, and birthday cake, and let the children enjoy the playgrounds, pedalos on the lake, and open green spaces. Organize classic party games like sack races, tug-of-war, and musical chairs for added entertainment.

Superhero Training Camp at a Local Adventure Park:
Turn your child''s birthday into an epic adventure by hosting a superhero training camp at a local adventure park. Activities like obstacle courses, zip-lining, and rope climbing can make the kids feel like real-life superheroes. Encourage them to dress up as their favourite characters for extra excitement.

Indoor Play Centers for All-Weather Fun:
Birmingham offers a range of indoor play centres perfect for birthday parties, regardless of the weather. These venues typically feature soft play areas, trampolines, slides, and ball pits, ensuring hours of entertainment for the little ones. Party packages include food, drinks, and a dedicated party host, making it a hassle-free option for parents.

Conclusion:

Planning a children''s birthday party in Birmingham, UK, doesn''t have to be stressful. With many unique venues and activities to choose from, you can create a memorable celebration tailored to your child''s interests and preferences. Whether it''s exploring museums, enjoying outdoor adventures, unleashing creativity, or indulging in culinary delights, there''s something for every young party-goer in Birmingham. So, get ready to plan an unforgettable birthday bash that will leave your child and their friends smiling from ear to ear.', 'blog-1712609578166-80126.jpeg', 1, '2024-04-09 03:52:58');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (22, 'Top 20 Places to Take Kids in the Summer in the Midlands, UK', 'Summer is the perfect time to explore the Midlands with your family. This region boasts a wealth of attractions that promise fun, adventure, and learning experiences for kids of all ages. Whether you''re looking for thrilling rides, fascinating wildlife, or interactive museums, the Midlands has it all. Here’s a roundup of the top 20 places to take your kids this summer.

1. Drayton Manor Theme Park (Staffordshire)
Drayton Manor is a family favorite with something for everyone. Younger kids will love Thomas Land, while thrill-seekers can enjoy rides like Apocalypse and Shockwave. Don’t miss the zoo and 4D cinema!

2. Twycross Zoo (Warwickshire)
Home to a vast array of primates and other exotic animals, Twycross Zoo offers interactive exhibits and engaging play areas, making it both educational and entertaining.

3. Warwick Castle (Warwickshire)
Warwick Castle combines history and fun. Kids can explore the medieval fortress, watch live jousting, and get lost in the Horrible Histories Maze. The interactive Knight School is a must-do.

4. West Midland Safari Park (Worcestershire)
A drive-through safari experience where you can see lions, elephants, and rhinos up close. The park also features a walk-through area, amusement rides, and a discovery trail.

5. Cadbury World (Birmingham)
For chocolate lovers, Cadbury World is a dream come true. Learn about the history of chocolate, see how it’s made, and enjoy plenty of free samples. The interactive exhibits are a hit with kids.

6. Thinktank, Birmingham Science Museum (Birmingham)
This interactive science museum offers hands-on exhibits, a planetarium, and a science garden. It’s perfect for curious kids who love to explore and learn.

7. The National Forest Adventure Farm (Staffordshire)
From animal encounters to large play areas, this adventure farm offers a mix of indoor and outdoor activities. Seasonal events like maize mazes and pumpkin picking add to the fun.

8. Conkers (Leicestershire)
Conkers is a discovery center set in the National Forest. With adventure playgrounds, high ropes, a 4D cinema, and nature trails, it’s an exciting and educational outing for kids.

9. The Black Country Living Museum (Dudley)
Step back in time at this open-air museum featuring a recreated Victorian village. Kids will love the old-fashioned fairground rides, traditional shops, and canal trips.

10. Stratford Butterfly Farm (Warwickshire)
Wander through the UK’s largest tropical butterfly paradise and encounter hundreds of free-flying butterflies. The farm also houses insects, spiders, and reptiles.

11. Alton Towers (Staffordshire)
One of the UK’s most famous theme parks, Alton Towers has rides for all ages, including CBeebies Land for younger children and thrilling coasters for teens and adults.

12. Sealife Birmingham (Birmingham)
Discover an underwater world at Sea Life Birmingham. Walk through the 360-degree ocean tunnel, see sharks, rays, and even meet the resident sea turtles.

13. LEGOLAND Discovery Centre (Birmingham)
Ideal for kids who love LEGO, this indoor attraction features interactive rides, a 4D cinema, and plenty of opportunities to build and play.

14. National Space Centre (Leicestershire)
Blast off into space at the National Space Centre. With its iconic Rocket Tower, planetarium shows, and interactive exhibits, it’s perfect for aspiring astronauts.

15. Ironbridge Gorge Museums (Shropshire)
Explore the birthplace of the Industrial Revolution through ten museums set in this UNESCO World Heritage Site. Kids can enjoy hands-on activities and historical reenactments.

16. Peak Wildlife Park (Staffordshire)
A walk-through zoo where kids can get up close to animals like lemurs, wallabies, and meerkats. The park also features play areas and picnic spots.

17. Cotswold Wildlife Park (Oxfordshire)
A bit of a drive, but worth it! This park is home to a diverse range of animals and beautiful gardens. Kids will love the adventure playground and the chance to feed the penguins.

18. Thinktank Planetarium (Birmingham)
Part of the Thinktank Science Museum, the planetarium offers stunning shows about space and our universe. It’s a magical experience for kids and adults alike.

19. Birmingham Botanical Gardens (Birmingham)
These beautiful gardens are perfect for a leisurely day out. Kids can explore the glasshouses, aviaries, and the playground while learning about different plant species.

20. The National Sealife Centre (Birmingham)
Another great spot for marine life enthusiasts, with interactive exhibits, touch pools, and fascinating creatures like sea horses, octopuses, and jellyfish.

Conclusion
The Midlands is a treasure trove of fun and educational experiences for kids. From thrilling theme parks and fascinating zoos to interactive museums and historical sites, there’s no shortage of places to explore. So pack your bags, grab your kids, and get ready for an unforgettable summer adventure in the heart of England!', 'blog-1717011287504-66121.jpeg', 1, '2024-05-28 04:40:10');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (24, 'Discover WayzAway: Your Ultimate Private Travel and Activity Journal', 'In an age where our lives are often shared openly on social media, the need for a personal and private space to document our experiences has never been more significant. Enter WayzAway—the innovative platform designed to transform how you record and revisit your travel adventures and daily activities. Here’s why WayzAway is the ideal choice for those seeking a blend of privacy, functionality, and inspiration in their journaling journey.

What is WayzAway?

WayzAway is a private travel and activity journal that allows users to record their memorable moments in a user-friendly, secure environment. Unlike traditional social media platforms that focus on public sharing, WayzAway offers a space for personal reflection and detailed documentation of your experiences, away from the prying eyes of the internet. This emphasis on privacy means you can relive your memories without the intrusion of algorithms or targeted ads.

Key Features of WayzAway

1.	Personalized Entries: WayzAway provides a streamlined process to create detailed journal entries. Whether you’re documenting a weekend hike, an overseas vacation, or a delightful meal at a local restaurant, WayzAway allows you to capture every detail. Users can upload photos, add descriptive text, and even include location data to build a rich tapestry of memories.

2.	Privacy-First Approach: At the core of WayzAway’s philosophy is privacy. The platform ensures that your data is yours alone, with no trending topics or suggested follows that might compromise your private moments. This focus on confidentiality makes it an excellent choice for users who prefer to keep their personal experiences away from the public eye.

3.	Inspirational Content: Despite its private nature, WayzAway offers a unique feature where users can explore the activities and adventures recorded by friends and family. This curated display of experiences serves as a wellspring of inspiration for your own future travels and activities, allowing you to discover new destinations and ideas.

4.	Simple and Intuitive Design: WayzAway’s interface is designed to be both aesthetically pleasing and functional. The minimalist layout ensures that your content stands out, and navigating through your journal entries is both easy and enjoyable. The app''s design ensures that a wealth of memories can be stored within a single image or entry, making it easy to revisit and cherish your past experiences.

5.	User Testimonials: The value of WayzAway is best reflected in the words of its users. As one user, Lauren, notes, “Anytime we log into WayzAway and see all the memories from years past, it brings a smile to our faces. It’s a great motivator to have more memorable experiences, big or small, in the future.” Another user, Val, appreciates the platform for its ability to inspire new activities, saying, “It’s really great to see what the people I care about are doing. It gives me so many ideas on ways to get out and find things to journal.”

Why Choose WayzAway?

1.	Enhanced Privacy: In a world where digital privacy is becoming increasingly scarce, WayzAway stands out by offering a truly private journaling experience. You have full control over your data and who gets to see it, ensuring that your memories remain personal and protected.

2.	Motivation to Explore: With WayzAway, every entry serves as a motivation to create new memories. The platform’s ability to store and display past experiences encourages users to seek out new adventures and activities to document, enriching their lives in the process.

3.	Organized Memory Keeping: WayzAway’s organized format helps you keep track of your experiences systematically. This is especially useful for avid travelers who want to maintain a detailed record of their journeys, complete with photos, notes, and geotags.

4.	Accessible Across Devices: WayzAway is designed to be accessible across various devices, ensuring that you can record and revisit your entries whether you''re at home or on the go. The app is available on Play store and iOS, providing a seamless experience across most devices.

Getting Started with WayzAway

To begin your journey with WayzAway, simply download the app or visit the site (WayzAway.com) and create your account. The intuitive setup will guide you through creating your first entry, and from there, you can start building your personal journal. Whether you’re looking to document a day out with friends, a solo hike in the mountains, or an exotic vacation, WayzAway is equipped to capture every moment beautifully.

In conclusion, WayzAway is more than just a journaling tool—it’s a platform that values your privacy and inspires you to live a life full of memorable experiences. Start your WayzAway journey today and ensure that your beautiful moments are never forgotten.


Photo by Jarritos Mexican Soda on Unsplash



  
', 'blog-1720112111009-59786.jpeg', 1, '2024-07-04 16:55:12');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (25, 'Experience Life''s Journeys with WayzAway: Your Ultimate Digital Journaling Companion for Family Memories', 'Discover the Magic of WayzAway

Imagine a place where every precious moment of your family’s adventures, from everyday activities to epic vacations, is captured and celebrated. WayzAway, the ultimate digital journaling platform, makes this dream a reality. Gone are the days of bulky scrapbooks and lost photos. Say hello to an easy, modern, and fun way to document your family’s journey.
WayzAway isn''t just a tool; it''s your family''s digital memory vault. It’s designed to be intuitive, engaging, and bursting with features that transform ordinary moments into extraordinary stories. Whether you''re chronicling a simple Sunday picnic or a grand tour across Europe, WayzAway makes journaling as effortless as living the experience itself.

Why WayzAway is Perfect for Your Family

1. User-Friendly Design

WayzAway offers a sleek and easy-to-navigate interface that lets you focus on what matters: capturing memories. You don’t need to be tech-savvy to use WayzAway. Just sign up, and you’re ready to start journaling your family’s experiences.

2. Multimedia Integration

WayzAway lets you seamlessly incorporate photos into your journal entries. Relive the scenic beauty of your road trips and those unforgettable first steps all in one place with vibrant pictures.

3. Real-Time Collaboration

Family journaling is a team effort with WayzAway. Share the fun of documenting memories by inviting your family members to contribute their perspectives. Mom’s view of the beach day might differ from Dad’s, and that’s the beauty of it!

4. Accessibility on the Go

Life’s best moments often happen away from home. WayzAway’s mobile app ensures you can journal wherever you are. Snap photos and jot down notes – all in the moment.

5. Advanced Organization Tools

With WayzAway, keeping your journal organized is a breeze. Tag entries by events, people, or locations. Use the search feature to find specific memories in seconds. Create custom folders for each family member, trip, or activity.

6. Secure and Private

Your family’s memories are priceless, and WayzAway keeps them safe. With top-notch encryption and regular backups, you can be confident that your journal is protected and private.

Getting Started with WayzAway

1. Sign Up and Set Up Your Profile

Head over to WayzAway.com and create an account. Setting up is simple. Personalize your profile with a family photo and write a brief introduction about your journaling goals. This adds a personal touch and sets the tone for your journaling journey.

2. Create Your First Journal

Start by creating your first journal. Maybe it’s a family vacation log or a daily life diary. Give it a catchy name like “Smith Family Adventures” or “The Daily Chronicles.” WayzAway lets you set up multiple journals, so feel free to get creative!

3. Invite Family Members

Send invites to family members via email or directly through WayzAway. They can join your journal, contribute comments, and enjoy reminiscing over shared experiences. 

Recording Family Experiences with WayzAway

Special Occasions and Milestones

Whether it’s a birthday, holiday, or a milestone like a graduation, WayzAway is perfect for documenting these significant events.

•	Event Summary: Start with a summary of the event. Include the date, place, and why it’s special.
•	Preparations: Capture the fun (and sometimes chaos) of getting ready. Photos of decorations, party planning lists, and the excitement leading up to the event are great additions.
•	Highlights: Record the best moments – the birthday cake reveal, opening gifts, or the family gathered around the holiday table.
•	Photos: Make sure to add photos. A picture of your child blowing out birthday candles or a series of photos from the holiday dinner can bring the entry to life.

Documenting Family Activities

1. Weekly Recaps
Summarise your weekly activities to capture the essence of your family''s life.
•	Activity Lists: List out the activities your family did during the week – movie nights, hikes, board games, or just a lazy Sunday.
•	Favorite Moments: Highlight what stood out. Did your daughter win her soccer game? Did you discover a new family favorite recipe? These moments are the heart of your journal.
•	Photos and Stories: Add photos and brief stories about each activity. A picture of your family hiking or a snapshot of your board game night can bring the recap to life.

2. Family Projects

Document family projects, whether it’s a home garden, a DIY craft, or even a charity event.
•	Project Goals: Outline the goal of your project. Are you planting a garden to grow fresh veggies, or building a treehouse for fun?
•	Steps and Progress: Keep a running log of steps taken and progress made. Include photos at each stage.
•	Challenges and Solutions: Document any challenges faced and how you overcame them. These details make for interesting reads later on.
•	Final Outcome: Capture the completion of the project. Add photos of the finished garden or treehouse, and celebrate the accomplishment.

3. Sports and Extracurricular Activities

From soccer games to school plays, document your children''s extracurricular activities in a vibrant way.
•	Event Details: Include the date, time, and location of the event.
•	Performance Highlights: Record the highlights – the winning goal, the standout performance in the play, or just the sheer joy on their faces.
•	Photos: Capture the action with photos. A picture of the winning goal or a photo of the costume can make the entry pop.

Recording Family Trips with WayzAway

During the Trip

Capture the essence of your trip with real-time journaling.
•	Daily Entries: Create daily entries that summarise the day’s activities. Include your adventures, meals, and any unexpected surprises.
•	Photo Albums: Create photo albums for each day or significant part of the trip. A picture of your family at a famous landmark or enjoying local cuisine adds a lot of flavour.
•	Photos of Maps and Tickets: Add photos of maps, tickets, or brochures to your entries. They provide context and are fun mementos to revisit.


Photo by Dana Marin (Amsterdamian) on Unsplash', 'blog-1720112484134-16705.jpeg', 1, '2024-07-04 17:01:24');
INSERT INTO public.blog_post (id, title, description, image, user_id, created_at) VALUES (27, 'Discover the Isle of Man: Top 15 Family-Friendly Destinations', 'The Isle of Man, nestled in the heart of the Irish Sea, is a treasure trove of natural beauty, rich history, and cultural heritage. Known for its scenic landscapes, ancient sites, and vibrant festivals, the island offers an array of activities and destinations perfect for family adventures. Whether you''re looking for outdoor excitement, educational experiences, or leisurely enjoyment, the Isle of Man has something for everyone. Here are the top 15 places to visit with family on this charming island.

1. Castle Rushen
Situated in the ancient capital of Castletown, Castle Rushen is one of the best-preserved medieval castles in Europe. This historic fortress provides a fascinating glimpse into the island''s past. Families can explore its well-preserved rooms, climb the towers for panoramic views, and learn about the castle''s role in Manx history through interactive exhibits. Children will especially enjoy the costumed guides and the opportunity to dress up in medieval attire.

2. Manx Museum
For a comprehensive overview of the Isle of Man''s history, culture, and natural environment, the Manx Museum in Douglas is a must-visit. The museum features a range of exhibits, from Viking artifacts and prehistoric fossils to a display on the world-famous TT motorcycle races. The interactive exhibits and children''s discovery zone make it an engaging experience for all ages.

3. Laxey Wheel and Mines Trail
The iconic Laxey Wheel, also known as the Lady Isabella, is the largest working waterwheel in the world. This impressive feat of Victorian engineering is a symbol of the island''s mining heritage. Families can climb to the top of the wheel for stunning views and then explore the nearby mines trail, where children can learn about the mining process and the lives of the miners.

4. Curraghs Wildlife Park
Nature-loving families will find Curraghs Wildlife Park a delightful experience. Located in the north of the island, this wildlife park is home to a wide range of animals from around the world, including red pandas, meerkats, and lemurs. The park also features play areas, a wetland nature trail, and a miniature railway, providing plenty of entertainment for young explorers.

5. Tynwald Hill and Arboretum
Tynwald Hill in St John''s is a unique cultural site where the world''s oldest continuous parliament meets annually. Families can explore the hill and the surrounding arboretum, which is home to a variety of native and exotic trees. The area also features a beautiful garden, perfect for a peaceful family picnic.

6. Peel Castle
Perched on St Patrick''s Isle, Peel Castle is a spectacular historical site with stunning views of the Irish Sea. The ruins of this ancient fortress offer a captivating journey through time, with informative displays and audio guides. The nearby sandy beach and vibrant Peel Marina make it an ideal spot for a family day out, complete with opportunities for swimming and enjoying fresh local seafood.

7. Snaefell Mountain Railway
For breathtaking views and a memorable adventure, hop aboard the Snaefell Mountain Railway. This electric railway takes you to the summit of Snaefell, the island''s highest peak, offering panoramic vistas of the island and, on clear days, views of England, Ireland, Scotland, and Wales. At the top, families can enjoy a meal at the café and explore the mountain''s unique flora and fauna.

8. The Great Laxey Mines Railway
This narrow-gauge railway offers a fun and educational experience, transporting visitors along a route once used by miners. The journey takes you through picturesque scenery, and the knowledgeable guides provide fascinating insights into the island''s mining history. It''s a charming and leisurely way to experience a piece of Manx heritage.

9. Groudle Glen Railway
Another delightful railway experience is the Groudle Glen Railway, a narrow-gauge railway that winds through the scenic Groudle Glen. This charming railway offers themed rides and special events, such as Santa trains during the Christmas season. The railway is perfect for young children and railway enthusiasts alike.

10. Cregneash Village
Step back in time at Cregneash, a traditional Manx crofting village preserved as a living museum. Here, families can explore traditional thatched cottages, watch demonstrations of traditional crafts, and meet native Manx Loaghtan sheep. The village offers a fascinating insight into the island''s rural past and is a peaceful spot to enjoy a stroll through the countryside.

11. Castle Mona and Douglas Promenade
Douglas, the island''s capital, boasts a beautiful promenade that stretches along the seafront. Families can enjoy a leisurely walk, take in the views, and visit attractions like Castle Mona, a historic building with a storied past. The promenade also offers plenty of opportunities for shopping, dining, and enjoying the seaside atmosphere.

12. Port Erin Beach and Milner''s Tower
Port Erin, a picturesque seaside village, features a stunning sandy beach that''s perfect for families. The calm waters are ideal for swimming and paddling, while the surrounding hills offer scenic hiking opportunities. A visit to Milner''s Tower, a distinctive folly overlooking the bay, provides excellent views and a bit of history.

13. Manx Electric Railway
The Manx Electric Railway is one of the island''s oldest and most scenic railways, running along the eastern coast from Douglas to Ramsey. The vintage trams offer a charming way to explore the island, with stops at picturesque villages and stunning coastal views. It''s a nostalgic and relaxing journey that the whole family will enjoy.

14. Calf of Man and Sound Visitor Centre
For those interested in wildlife and nature, a visit to the Calf of Man is highly recommended. This small island off the southern coast is a haven for birdwatchers, with many species nesting there. The nearby Sound Visitor Centre offers informative displays about the area''s natural history and stunning views of the surrounding waters, where seals and other marine life can often be spotted.

15. Ape Mann Adventure Park and Segway Tours
For an adrenaline-filled day out, Ape Mann Adventure Park offers high ropes courses, zip lines, and a variety of outdoor challenges. The park is suitable for older children and adults looking for a fun physical activity. Additionally, Segway Tours provide a unique way to explore the island''s scenic trails and countryside, making for an exciting family adventure.


The Isle of Man is a perfect destination for families seeking a blend of history, nature, and adventure. With its diverse attractions, from medieval castles and museums to wildlife parks and scenic railways, the island offers endless opportunities for exploration and discovery. Whether you''re interested in outdoor activities, cultural experiences, or simply relaxing by the sea, the Isle of Man has something to offer every family. Plan your visit today and create unforgettable memories on this enchanting island.', 'blog-1722859931251-72724.jpeg', 1, '2024-08-05 12:12:12');


--
-- Data for Name: event_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (38, 'Joined WayzAway!', '2023-10-23 00:00:00', '15:13:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 17, NULL, '2023-10-24 21:13:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (39, 'Pumpkins R US', '2023-10-14 00:00:00', '02:00:00', '06:00:00', 'Warwickshire', 'Halloween shop, pumpkins, rides and cafe', 'Family Attractions', '["event-1698193208883-40077.jpg", "event-1698157103157-81901.jpg", "event-1698157103309-30599.jpg", "event-1698157103983-67828.jpg", "event-1698193208885-71820.jpg"]', false, NULL, 17, NULL, '2023-10-24 21:18:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (40, 'RAF Museum', '2023-09-30 00:00:00', '12:00:00', '05:00:00', 'Cosford', 'Museum dedicated to the history of aviation and the Royal Air Force. There is a playground for kids, VR rides and a gift shop.', 'Museums & Exhibitions', '["event-1698157879740-87264.jpg", "event-1698157879762-48239.jpg", "event-1698157879787-50009.jpg", "event-1698157879805-64799.jpg", "event-1698157879821-24316.jpg"]', false, NULL, 17, NULL, '2023-10-24 21:31:22');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (41, 'Rock Up Wall Climbing', '2023-08-25 00:00:00', '12:30:00', '03:00:00', 'Birmingham', 'Indoor Wall and Tower climbing for adults and children. Has a soft play area for little kids.', 'Indoor Activities', '["event-1698158650299-37511.jpg", "event-1698158650311-89702.jpg", "event-1698158650323-80019.jpg", "event-1698158650333-74107.jpg", "event-1698158650342-39657.jpg"]', false, NULL, 17, NULL, '2023-10-24 21:44:13');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (42, 'Wyre Forest', '2023-08-23 00:00:00', '12:00:00', '18:00:00', 'Bewdley', 'Large woodland nature reserve. Great for long walks, horse riding cycling, picnic spots and has plenty of outdoor activities for adults and children. There is a go ape in the forest for zip lining, treetop challenges and treetop adventures.', 'Outdoor Activities', '["event-1698159081988-16174.jpg", "event-1698159082010-28921.jpg", "event-1698159082035-94849.jpg"]', false, false, 17, NULL, '2023-10-24 21:51:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (43, 'Indoor Roller Skating', '2023-08-19 00:00:00', '13:00:00', '16:00:00', 'Onchan, Isle of Man', 'Large indoor room for roller blading. For adults and kids. There''s a cafe nearby for food.', 'Indoor Activities', '["event-1698159428937-93510.jpg", "event-1698159345958-85575.jpg", "event-1698159345971-19014.jpg"]', false, NULL, 17, NULL, '2023-10-24 21:55:48');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (44, 'Maughold Beach', '2023-08-04 00:00:00', '12:00:00', '16:00:00', 'Maughold, Isle of Man', 'Located on the east of Isle of Man. Lovely cost line and scenery. Nice walk along the beach.', 'Nature Walks', '["event-1698160496474-22677.jpg", "event-1698160496491-72195.jpg", "event-1698160496509-71894.jpg"]', false, NULL, 17, NULL, '2023-10-24 22:14:58');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (45, 'The Great Laxey Wheel', '2023-08-03 00:00:00', '12:00:00', '16:00:00', 'Laxey, Isle of Man', 'Historic Laxey Wheel built into the hillside above the village if Laxey. The wheel was built in 1854 to pump water. You can use the steep steps to climb to the very top of the wheel. Also includes a quick trip into the nearby old mine.', 'Culture & History', '["event-1698160868140-99713.jpg", "event-1698160868168-44336.jpg", "event-1698160868185-79874.jpg", "event-1698160868244-43236.jpg", "event-1698160868753-4068.jpg"]', false, NULL, 17, NULL, '2023-10-24 22:21:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (46, 'Glen Wyllin', '2023-07-25 00:00:00', '12:30:00', '17:30:00', 'Kirk Michael, Isle of Man', 'Stopped at the beach. But also has a campsite', 'Outdoor Activities', '["event-1698161507425-18338.jpg", "event-1698161507449-76848.jpg", "event-1698161507467-42844.jpg"]', false, NULL, 17, NULL, '2023-10-24 22:31:49');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (47, 'Woodgate Valley Country Park', '2023-07-02 00:00:00', '16:00:00', '19:00:00', 'Birmingham', 'Rural park with Brook running through the middle. Great for long walks and horse riding. There is an apple orchard for apple picking. And a children''s playground. The park also has a small farm in the middle with pigs, goats, chickens and cows.', 'Parks & Garden', '["event-1698162002083-32063.jpg", "event-1698162002110-5631.jpg", "event-1698162002185-18683.jpg", "event-1698162002216-19768.jpg", "event-1698162002275-17268.jpg"]', false, NULL, 17, NULL, '2023-10-24 22:40:05');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (48, 'Manor Farm Fruits', '2023-07-01 00:00:00', '12:30:00', '18:45:00', 'Tamworth', 'Fruit picking. A wide range if fruits available to pick in the summer. There''s a playground and bouncy castle for kids. Outdoor BBQ and cafe.', 'Outdoor Activities', '["event-1698162338867-96293.jpg", "event-1698162338886-93629.jpg", "event-1698162338900-12262.jpg", "event-1698162338915-35344.jpg", "event-1698162338939-63296.jpg"]', false, NULL, 17, NULL, '2023-10-24 22:45:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (49, 'Claremont Landscape Garden', '2023-06-24 00:00:00', '12:00:00', '17:00:00', 'Esher, Surrey', 'Grade 1 listed garden. Great nature walk, woodland and beautiful lake. There''s a playground and cafe on site. Part of the National Trust.', 'Nature Walks', '["event-1698162739047-84718.jpg", "event-1698162739060-36366.jpg", "event-1698162739077-8596.jpg", "event-1698162739095-33414.jpg", "event-1698162739110-51660.jpg"]', false, NULL, 17, NULL, '2023-10-24 22:52:22');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (50, 'Gheluvelt Park', '2023-06-03 00:00:00', '12:30:00', '16:15:00', 'Worcester', 'Public park with plenty of space for outdoor activities, walking and picnics. There is a splash park in the summer and playground for kids. There is a small shop that sells drinks and refreshments and tennis courts.', 'Parks & Garden', '["event-1698163327672-37179.jpg", "event-1698163169784-24786.jpg", "event-1698163327674-41312.jpg"]', false, NULL, 17, NULL, '2023-10-24 22:59:31');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (51, 'Habberley Trail', '2023-04-15 00:00:00', '12:00:00', '18:30:00', 'Low Habberley, Kidderminster', 'Outdoor nature adventure and walk. Includes plenty of fun outdoor activities such as zip lining, bouncy castles for kids, large slides, rides and more
There''s a small cafe that sells food and drinks.', 'Adventure Activities', '["event-1698163680777-80735.jpg", "event-1698163680788-47299.jpg", "event-1698163680805-34344.jpg", "event-1698163680818-99740.jpg", "event-1698163680844-43061.jpg"]', false, NULL, 17, NULL, '2023-10-24 23:08:05');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (52, 'Dudley Canal and Caverns', '2023-04-08 00:00:00', '12:00:00', '15:30:00', 'Dudley', 'Boat tour of black country canal and tunnel networks. We did this around Easther, hence the Easter theme.', 'Tours', '["event-1698164068890-43021.jpg", "event-1698164068919-37719.jpg", "event-1698164068925-71238.jpg", "event-1698164068935-29602.jpg", "event-1698164068949-91634.jpg"]', false, NULL, 17, NULL, '2023-10-24 23:14:32');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (53, 'Sheldon Country Park', '2023-03-19 00:00:00', '01:45:00', '15:30:00', 'Birmingham', 'Country Park and Farm with children''s play area and walking path that leads to the airport.', 'Parks & Garden', '["event-1698166494776-7353.jpg", "event-1698166494795-31064.jpg", "event-1698166494809-62488.jpg", "event-1698189235007-74926.jpg", "event-1698189235009-11882.jpg"]', false, NULL, 17, NULL, '2023-10-24 23:54:56');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (54, 'Basel', '2022-08-17 00:00:00', '00:00:00', '18:30:00', 'Switzerland', 'Holiday to Basel', 'Holidays', '["event-1698166944994-1544.jpg", "event-1698166945007-57625.jpg", "event-1698166945033-94775.jpg", "event-1698166945048-2704.jpg", "event-1698166945061-73946.jpg"]', false, NULL, 17, NULL, '2023-10-25 00:02:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (55, 'Wrens Nest National Nature Reserve', '2022-12-04 00:00:00', '14:29:00', '17:30:00', 'Dudley', 'Geological location. Circular walk around large limestone outcrop.', 'Nature Walks', '["event-1698186614503-49788.jpg", "event-1698186614504-91899.jpg", "event-1698171025890-39138.jpg", "event-1698171025913-74783.jpg", "event-1698186614507-21393.jpg"]', false, NULL, 17, NULL, '2023-10-25 01:10:29');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (56, 'Center Parcs', '2022-06-24 00:00:00', '00:30:00', '19:30:00', 'Whinfell', 'Wildlife sanctuary on the edge of Lake District. Holiday Park with wide variety of indoor and outdoor activities for adults and kids.', 'Holidays', '["event-1698172086974-93036.jpg", "event-1698172040435-10233.jpg", "event-1698172040520-90695.jpg", "event-1698172040687-30475.jpg", "event-1698172086990-28916.jpg"]', false, NULL, 17, NULL, '2023-10-25 01:27:25');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (57, 'Sea Life Centre', '2019-04-27 00:00:00', '12:30:00', '18:30:00', 'Birmingham', 'Large Aquarium with displays of sea creatures', 'Family Attractions', '["event-1698172259309-48047.jpg", "event-1698172259310-40918.jpg", "event-1698172259310-27404.jpg", "event-1698172259311-31910.jpg"]', false, NULL, 17, NULL, '2023-10-25 01:31:00');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (58, 'Ash End Farm', '2019-08-18 00:00:00', '12:30:00', '19:34:00', 'Tamworth', 'Farm with tractor wides, animal feeding and large play area for kids', 'Animal and Wildlife', '["event-1698172493654-18724.jpg", "event-1698172493654-90242.jpg", "event-1698172493655-5299.jpg", "event-1698172493656-53158.jpg"]', false, NULL, 17, NULL, '2023-10-25 01:34:54');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (59, 'Playa Del Carmen', '2019-09-27 00:00:00', '00:35:00', '23:30:00', 'Lanzarote', 'Resort town on southeast cost of Lanzarote. Plenty of sandy beaches, restaurants and long walks in the warm weather.', 'Holidays', '["event-1698172699598-7549.jpg", "event-1698172699599-689.jpg", "event-1698172699600-12431.jpg", "event-1698172699601-1578.jpg"]', false, NULL, 17, NULL, '2023-10-25 01:38:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (60, 'Brueton Park Lake', '2020-12-19 00:00:00', '12:30:00', '15:30:00', 'Solihull', 'Big Park with great easy pathway for long walks and cycling. Play area for children.', 'Parks & Garden', '["event-1698172973949-46919.jpg"]', false, NULL, 17, NULL, '2023-10-25 01:42:54');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (61, 'Highbury Park and Highbury Hall', '2020-11-08 00:00:00', '14:30:00', '17:29:00', 'Moseley', 'Park with plenty of woodland and an historic house. Large open spaces for the dog to run around.', 'Parks & Garden', '["event-1698173181388-70203.jpg", "event-1698173181389-95707.jpg", "event-1698173181391-67785.jpg", "event-1698173181392-9744.jpg"]', false, NULL, 17, NULL, '2023-10-25 01:46:22');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (62, 'Coombe Abbey', '2020-10-31 00:00:00', '12:30:00', '17:30:00', 'Binley, Warwickshire', 'Large park with children play area, independent shops, cafe, long walks and outdoor activites. There''s a large historic house in the park with  maze garden and lake.', 'Parks & Garden', '["event-1698173596057-42691.jpg", "event-1698173596059-39428.jpg", "event-1698173596060-41245.jpg", "event-1698173596062-87469.jpg"]', false, NULL, 17, NULL, '2023-10-25 01:53:16');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (63, 'Apple Orchard', '2020-09-26 00:00:00', '12:30:00', '17:30:00', 'Woodgate Valley Park', 'Apple picking located in the orchard in Woodgate Valley Park.', 'Outdoor Activities', '["event-1698173740081-77003.jpg", "event-1698173740082-92631.jpg", "event-1698173740083-34109.jpg"]', false, NULL, 17, NULL, '2023-10-25 01:55:40');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (64, 'Nature Walk', '2020-09-20 00:00:00', '12:00:00', '06:00:00', 'Coughton', 'Long walk through woodlands and farmland.', 'Nature Walks', '["event-1698174095982-80474.jpg", "event-1698174095984-19855.jpg", "event-1698174095985-90484.jpg", "event-1698174095986-44095.jpg", "event-1698174095986-18617.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:01:37');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (65, 'Clent Hills', '2020-08-02 00:00:00', '12:30:00', '05:30:00', 'Clent', 'Countryside haven that is part of the National Trust', 'Nature Walks', '["event-1698174389835-75440.jpg", "event-1698174389835-5024.jpg", "event-1698174389836-3541.jpg", "event-1698174389837-9580.jpg", "event-1698174389838-76877.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:06:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (66, 'Manor Farm Fruits', '2020-07-18 00:00:00', '12:30:00', '12:30:00', 'Tamworth', 'Fruit picking farm', 'Outdoor Activities', '["event-1698174614286-68575.jpg", "event-1698174614287-99899.jpg", "event-1698174614289-41499.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:10:15');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (67, 'Lickey Hills', '2020-07-12 00:00:00', '01:30:00', '17:30:00', 'Cofton', 'Lickey Hills is a large country park. But this was a walk through the wooded section of the park.', 'Parks & Garden', '["event-1698174788813-79786.jpg", "event-1698174788813-80499.jpg", "event-1698174788814-41446.jpg", "event-1698174788815-30641.jpg", "event-1698174788816-30435.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:13:10');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (68, 'Atwell Farm', '2020-07-11 00:00:00', '12:30:00', '18:30:00', 'Redditch', 'Met and fed animals. Enjoyed indoor and outdoor play areas, a jumping pillow and some art and craft', 'Animal and Wildlife', '["event-1698175057072-50350.jpg", "event-1698175057073-59712.jpg", "event-1698175057075-59976.jpg", "event-1698175057075-52077.jpg", "event-1698175057076-73945.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:17:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (69, 'Cannon Hill', '2020-03-03 00:00:00', '12:30:00', '17:30:00', 'Birmingham', 'Large park in the middle of Birmingham. Great for walks and there''s a play area for children. ', 'Parks & Garden', '["event-1698175258486-93972.jpg", "event-1698175258487-8337.jpg", "event-1698175258489-97050.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:20:59');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (70, 'Charlecote Park', '2020-02-29 00:00:00', '12:30:00', '18:30:00', 'Warwick', 'A historic grand 16th century country house surrounded by a deer park on the banks of River Avon.', 'Historic Houses & Castles', '["event-1698175449849-88668.jpg", "event-1698175449850-24699.jpg", "event-1698175449852-7946.jpg", "event-1698175449853-56250.jpg", "event-1698175449854-95859.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:24:10');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (71, 'Villa el Palacete', '2020-02-17 00:00:00', '12:30:00', '18:30:00', 'Lanzarote', 'Spent 5 nights in a large villa in Lanzarote for mums 60th birthday.', 'Holidays', '["event-1698175809810-47227.jpg", "event-1698175809810-95488.jpg", "event-1698175809812-99194.jpg", "event-1698175809812-91068.jpg", "event-1698175809814-14407.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:30:10');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (72, 'Packwood House', '2020-02-01 00:00:00', '12:30:00', '17:30:00', 'Solihull', 'Tutor manor house in Solihull. Owned by the National Trust and known for its garden of yews.', 'Historic Houses & Castles', '["event-1698176202791-90988.jpg", "event-1698176202792-87850.jpg", "event-1698176202794-43106.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:34:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (73, 'Hanbury Hall', '2020-02-08 00:00:00', '12:40:00', '19:35:00', 'Hanbury, Worcestershire', 'Large 18th century stately home surrounded by large open fields and gardens.', 'Historic Houses & Castles', '["event-1698176406862-43121.jpg", "event-1698176406864-61820.jpg", "event-1698176406865-52222.jpg", "event-1698176406866-96251.jpg", "event-1698176406867-32963.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:40:07');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (74, 'Adventure Mini Golf', '2021-12-11 00:00:00', '14:35:00', '17:30:00', 'Star City, Birmingham', '18 holes indoor mini adenture golf.', 'Sport & Leisure', '["event-1698176598728-14072.jpg", "event-1698176559193-22110.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:42:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (75, 'Wightwick Manor', '2022-01-08 00:00:00', '12:30:00', '18:30:00', 'Wolverhampton', 'A Victorian Manor owned by the National Trust. The house is surrounded by woodland, gardens. There is a woodland play area in the woods.', 'Historic Houses & Castles', '["event-1698176907295-25617.jpg", "event-1698176907296-69578.jpg", "event-1698176907298-78328.jpg", "event-1698176907299-62325.jpg", "event-1698176907301-37307.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:48:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (76, 'Baddesley Clinton', '2022-01-15 00:00:00', '12:30:00', '18:30:00', 'Baddesley, Warwickshire', 'A moated Manor house originating from the 13th century. Located in the middle of the Forest of Arden and owned by the National Trust.', 'Historic Houses & Castles', '["event-1698177323490-95385.jpg", "event-1698177323492-76932.jpg", "event-1698177323493-15170.jpg", "event-1698177323494-41318.jpg", "event-1698177323495-7328.jpg"]', false, NULL, 17, NULL, '2023-10-25 02:55:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (77, 'Upton House & Garden', '2022-01-22 00:00:00', '12:30:00', '18:30:00', 'Banbury', 'Historic house built on the site of hamlet of Upton. The house and gardens are owned by the National Trust.', 'Historic Houses & Castles', '["event-1698177607987-2741.jpg", "event-1698177607987-41126.jpg", "event-1698177607989-23580.jpg", "event-1698177607990-62056.jpg", "event-1698177607992-74924.jpg"]', false, NULL, 17, NULL, '2023-10-25 03:00:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (78, 'Cannon Hill Park', '2022-01-23 00:00:00', '12:30:00', '18:30:00', 'Birmingham', 'Large park in middle of Birmingham with excellent pathway for walking, running and cycling. Plenty of open grass area for children and dogs to play.', 'Parks & Garden', '["event-1698177903017-68555.jpg", "event-1698177903020-99248.jpg", "event-1698177903023-75124.jpg", "event-1698177903028-20674.jpg", "event-1698177903029-42530.jpg"]', false, NULL, 17, NULL, '2023-10-25 03:05:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (79, 'Berrington Hall', '2022-02-05 00:00:00', '12:30:00', '18:30:00', 'Leominster', 'A country house owned by the National Trust. A Georgian neoclassical mansion by Henry Rolland built in 1778. It''s surrounded by browns final landscape and gardens. ', 'Historic Houses & Castles', '["event-1698178242125-43362.jpg", "event-1698178242126-54287.jpg", "event-1698178242127-87040.jpg", "event-1698178242128-8403.jpg", "event-1698178242129-16744.jpg"]', false, NULL, 17, NULL, '2023-10-25 03:10:42');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (80, 'Rush Trampoline', '2022-03-04 00:00:00', '01:30:00', '18:30:00', 'Stirchley, Birmingham', 'A large trampoline park for children. Plenty of fun and unique activities.', 'Indoor Activities', '["event-1698178478406-89577.jpg", "event-1698178478407-47556.jpg"]', false, NULL, 17, NULL, '2023-10-25 03:14:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (81, 'Croome Park', '2022-02-12 00:00:00', '12:30:00', '17:30:00', 'Worcestershire', 'Mid 18th-century mansion surrounded by extensive landscaped parkland at Croome D''Abitot. The property is owned by the National Trust.', 'Historic Houses & Castles', '["event-1698179144571-67151.jpg", "event-1698179144571-89287.jpg", "event-1698179144572-76403.jpg", "event-1698179144573-71287.jpg", "event-1698179144574-9677.jpg"]', false, NULL, 17, NULL, '2023-10-25 03:25:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (82, 'Hippodrome & Las Iguanas', '2022-02-25 00:00:00', '16:30:00', '20:45:00', 'Birmingham', 'Ballet show for children and restaurant after.', 'Theatre', '["event-1698179965760-45981.jpg", "event-1698179965760-69086.jpg", "event-1698179965761-25382.jpg", "event-1698179965762-72473.jpg"]', false, NULL, 17, NULL, '2023-10-25 03:39:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (83, 'Hanbury Hall', '2022-02-26 00:00:00', '12:30:00', '17:15:00', 'Hanbury, Worcestershire', '18 Century House owned by the National Trust', 'Historic Houses & Castles', '["event-1698180169732-76214.jpg", "event-1698180169734-56860.jpg", "event-1698180169735-31615.jpg", "event-1698180169738-63827.jpg", "event-1698180169740-83656.jpg"]', false, NULL, 17, NULL, '2023-10-25 03:42:50');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (84, 'Play 360', '2022-03-20 00:00:00', '01:30:00', '19:30:00', 'Redditch', 'Soft play and Party venue. The center also has rides for kids and plenty of toys for kids.', 'Play Centres', '["event-1698180447328-12887.jpg", "event-1698180447328-76827.jpg"]', false, NULL, 17, NULL, '2023-10-25 03:46:52');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (85, 'Coughton Court', '2022-03-12 00:00:00', '12:30:00', '18:30:00', 'Alcester', 'Grade I English Tudor country house owned by the National Trust. The house holds a variety of Catholic treasures and is set in a beautiful garden.
', 'Historic Houses & Castles', '["event-1698180859583-5047.jpg", "event-1698180859584-98158.jpg", "event-1698180859585-22777.jpg", "event-1698180859586-19378.jpg", "event-1698180859587-74408.jpg"]', false, NULL, 17, NULL, '2023-10-25 03:54:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (86, 'Baggeridge Country Park', '2022-04-11 00:00:00', '13:30:00', '18:25:00', 'Dudley', 'Country Park with acres of open space for walking and cycling. There''s a children play area, open grass to play and a high rope adventure area.', 'Parks & Garden', '["event-1698181467416-38636.jpg", "event-1698181467419-21662.jpg", "event-1698181467421-35335.jpg", "event-1698181467423-71283.jpg", "event-1698181467425-10098.jpg"]', false, NULL, 17, NULL, '2023-10-25 04:04:29');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (87, 'Old Hall', '2022-04-16 00:00:00', '12:30:00', '19:30:00', 'Wolverhampton', 'One of the hiding places of Charles II during his escape to France following defeat at Battle of Worcester in 1651. We visited around easther and took part in the egg hunt. The house is surrounded by woodland and a curated garden. We played games from Elizabethan times in the garden.', 'Historic Houses & Castles', '["event-1698181749551-62984.jpg", "event-1698181749555-24122.jpg", "event-1698181749557-66493.jpg", "event-1698181749558-56160.jpg"]', false, NULL, 17, NULL, '2023-10-25 04:09:11');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (88, 'Kingsbury Water Park', '2022-05-02 00:00:00', '12:30:00', '18:15:00', 'Sutton Coldfield', 'The park has fifteen lakes and situated in over 600 acres of land. There is a miniature railway to ride, a children''s play area, you can hire bikes and plenty of outdoor activities for children.', 'Parks & Garden', '["event-1698182334535-63348.jpg", "event-1698182334536-96159.jpg", "event-1698182334539-36788.jpg"]', false, NULL, 17, NULL, '2023-10-25 04:18:56');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (89, 'Upper Bittell Reservoir', '2022-07-11 00:00:00', '16:30:00', '19:30:00', 'Barnt Green, Cofton', 'Wall around the Bittell Reservoir in Cofton.', 'Nature Walks', '["event-1698182844460-85699.jpg", "event-1698182844462-44556.jpg", "event-1698182844473-16882.jpg"]', false, NULL, 17, NULL, '2023-10-25 04:27:25');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (90, 'Lido in Cirencester ', '2022-07-16 00:00:00', '11:00:00', '19:30:00', 'Cirencester, Cotsworld', 'Visited the Lido in Cirencester. Then explored the Cotsworld town before stopping at a pub for dinner.', 'Day Trips', '["event-1698183225297-98713.jpg", "event-1698183225299-97617.jpg", "event-1698183225301-98569.jpg", "event-1698183225305-68998.jpg", "event-1698183225307-98763.jpg"]', false, NULL, 17, NULL, '2023-10-25 04:33:47');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (91, 'Earlswood Lakes', '2022-07-17 00:00:00', '02:35:00', '17:30:00', 'Solihull', 'Man made reservoirs in Solihull. Great for a nice walk around the lake.', 'Nature Walks', '["event-1698183402524-5044.jpg", "event-1698183402526-21001.jpg", "event-1698183402527-70524.jpg"]', false, NULL, 17, NULL, '2023-10-25 04:36:43');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (92, 'Chasewater Country Park', '2022-08-07 00:00:00', '13:00:00', '17:30:00', 'Brownhills', 'Large park with a walking path around a beautiful lake. Includes a lakeside cafe, art and craft, activities like wake-boarding, sailing and water skiing. There were also trampoline for kids and a play area.', 'Parks & Garden', '["event-1698184184244-88731.jpg", "event-1698184184246-68141.jpg", "event-1698184184247-41234.jpg"]', false, NULL, 17, NULL, '2023-10-25 04:49:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (93, 'City Walk', '2022-08-27 00:00:00', '12:30:00', '20:29:00', 'Birmingham', 'Day out in Birmingham', 'General', '["event-1698184382540-79708.jpg", "event-1698184382545-5447.jpg", "event-1698184382546-21428.jpg", "event-1698184382548-26638.jpg"]', false, NULL, 17, NULL, '2023-10-25 04:53:04');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (94, 'Mount Pilatus', '2022-08-21 00:00:00', '11:30:00', '20:30:00', 'Switzerland', 'Took a gondola up the mountain. Then a train down. Up in the moutain we explored the tunnels and took in the sights.', 'Day Trips', '["event-1698184761516-68822.jpg", "event-1698184761518-43136.jpg", "event-1698184761519-28138.jpg", "event-1698184761520-67525.jpg", "event-1698184761521-2664.jpg"]', false, NULL, 17, NULL, '2023-10-25 04:59:23');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (95, 'Colmar', '2022-08-20 00:00:00', '09:30:00', '21:30:00', 'France', 'Day trip from Basel to the markets in Colmar', 'Day Trips', '["event-1698184905201-88090.jpg", "event-1698184905202-63019.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:01:46');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (96, 'Live Peter Rabbit Show', '2022-08-28 00:00:00', '14:30:00', '17:30:00', 'Birmingham', 'Live play of Peter Rabbit in the park', 'Live Shows', '["event-1698185095544-81464.jpg", "event-1698185095547-2262.jpg", "event-1698185095549-52183.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:04:57');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (97, 'Basel Zoo', '2022-08-23 00:00:00', '14:05:00', '17:30:00', 'Basel', 'Switzerland''s biggest zoo. ', 'Animal and Wildlife', '["event-1698185210370-10338.jpg", "event-1698185210372-68419.jpg", "event-1698185210374-15391.jpg", "event-1698185210376-48839.jpg", "event-1698185210377-82608.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:06:52');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (98, 'Milkshake Live', '2022-09-24 00:00:00', '15:15:00', '17:30:00', 'Coventry', 'Live show of Milkshake', 'Theatre', '["event-1698185343102-7874.jpg", "event-1698185343103-4748.jpg", "event-1698185343104-95441.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:09:04');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (99, 'Charlecote Park', '2022-10-01 00:00:00', '13:29:00', '14:30:00', 'Warwick', '16th century house surrounded by a deer park.', 'Historic Houses & Castles', '["event-1698185896523-38759.jpg", "event-1698185785208-83346.jpg", "event-1698185785210-17814.jpg", "event-1698185896524-35486.jpg", "event-1698185785212-49816.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:16:27');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (100, 'Packwood House', '2022-11-12 00:00:00', '14:15:00', '18:30:00', 'Solihull', 'Tudor Manor house sorrounded yew garden owned by thr National Trust.', 'Historic Houses & Castles', '["event-1698186127454-46241.jpg", "event-1698186127456-18755.jpg", "event-1698186127457-62602.jpg", "event-1698186127458-21859.jpg", "event-1698186127459-31847.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:22:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (101, 'Jimmy Spices', '2022-12-17 00:00:00', '17:30:00', '20:30:00', 'Birmingham', 'Global buffet restaurant on Broad Street.', 'Food & Drinks', '["event-1698186838728-73839.jpg", "event-1698186838730-54210.jpg", "event-1698186838731-50905.jpg", "event-1698186838732-4037.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:34:00');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (464, 'Joined WayzAway!', '2024-07-13 00:00:00', '20:00:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 189, NULL, '2024-07-14 04:00:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (102, 'Basel Munster', '2022-08-18 00:00:00', '13:30:00', '18:30:00', 'Basel', 'Originally a Catholic cathedral. Now a Reformed Protestant church. We were able to climb the towers all the way to the top.', 'Culture & History', '["event-1698187052801-25942.jpg", "event-1698187052802-34769.jpg", "event-1698187052803-98773.jpg", "event-1698187052805-26388.jpg", "event-1698187052806-24585.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:37:34');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (103, 'Shustoke Reservoir', '2023-01-21 00:00:00', '13:30:00', '16:30:00', 'Coleshill', '9km Circular walking path around Shustoke Reservoir with beautiful views and wildlife.', 'Nature Walks', '["event-1698187666143-25179.jpg", "event-1698187666144-35170.jpg", "event-1698187666145-24881.jpg", "event-1698187666146-2940.jpg", "event-1698187666147-78033.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:47:48');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (104, 'Chinese New Year', '2023-01-22 00:00:00', '11:30:00', '16:30:00', 'Birmingham', 'Chinese New year celebrations in the Chinese Quarter. Live shows, performances and celebrations.', 'Live Shows', '["event-1698187861658-55288.jpg", "event-1698187861659-54156.jpg", "event-1698187861661-76379.jpg", "event-1698187861664-38974.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:51:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (105, 'Woodgate Valley Park', '2023-01-29 00:00:00', '16:45:00', '18:30:00', 'Birmingham', 'Circular walk through the woods and around a horse field.', 'Nature Walks', '["event-1698188024637-57724.jpg", "event-1698188024638-91314.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:53:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (106, 'Biddulph Grange Garden', '2023-02-04 00:00:00', '12:30:00', '17:30:00', 'Stoke-on-Trent', 'National Trust landscaped garden.', 'Parks & Garden', '["event-1698188206178-39201.jpg", "event-1698188206179-38764.jpg", "event-1698188206180-54325.jpg", "event-1698188206182-7782.jpg", "event-1698188206183-75073.jpg"]', false, NULL, 17, NULL, '2023-10-25 05:56:48');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (107, 'The Falconry Centre', '2023-03-11 00:00:00', '13:30:00', '16:30:00', 'Hagley', 'Located in Webbs Garden Centre. A lovely little place with beautiful birds.', 'Animal and Wildlife', '["event-1698188457583-97882.jpg", "event-1698188457584-70597.jpg", "event-1698188457586-44766.jpg", "event-1698188457588-38013.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:00:59');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (108, 'Witley Court and Gardens', '2023-03-11 00:00:00', '12:30:00', '18:15:00', 'Worcestershire ', 'Magnificent house built in 17th century. But now lays in ruin after a fire in 1937.

Beautiful gardens, walking path, tree house, wobbly Bridge and Great Witley Chruch.', 'Historic Houses & Castles', '["event-1698188911145-95037.jpg", "event-1698188911146-94083.jpg", "event-1698188911149-23783.jpg", "event-1698188911149-64781.jpg", "event-1698188911151-7613.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:08:33');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (109, 'Mary Stevens Park', '2023-03-12 00:00:00', '14:30:00', '17:30:00', 'Stourbridge', 'Public park opened in 1931. Large grass fields ideal for play and dogs. There''s a play area for children and a cafe.', 'Parks & Garden', '["event-1698189099517-23022.jpg", "event-1698189099519-73912.jpg", "event-1698189099520-97183.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:11:40');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (110, 'Sedgley Adventure Golf', '2023-03-25 00:00:00', '12:30:00', '14:00:00', 'Dudley', 'Outdoor mini golf', 'Sport & Leisure', '["event-1698189362608-54523.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:16:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (111, 'Black Country Museum', '2023-03-25 00:00:00', '12:30:00', '19:30:00', 'Dudley', 'An open-air museum of rebuilt historic buildings in Dudley. Museum staff role play as characters from the late 19th and early 20th century. The museum contains many of the tools and equipments used during mining and you can visit one of the mines in a guided tour. The village and shops around the mines have been rebuilt to match early 20th century lifestyle.', 'Museums & Exhibitions', '["event-1698189707342-46332.jpg", "event-1698189707344-48597.jpg", "event-1698189707345-7663.jpg", "event-1698189707346-95093.jpg", "event-1698189707347-60732.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:21:49');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (112, 'Kenilworth Castle and Elizabeth Ian Garden', '2023-04-03 00:00:00', '12:30:00', '18:30:00', 'Warwickshire', 'Used to be one of the country''s most formidable fortresses. Robert Dudley later transformed it into a spectacular Palace in order to impress Queen Elizabeth I.

We partook in an Easter egg hunt, watched a live medieval show and walked around the ruined castle. There is a cafe and shop on site.

There is also a museum with information detailing the relationship between Elizabeth I and Robert Dudley.', 'Historic Houses & Castles', '["event-1698190074879-78726.jpg", "event-1698190074881-22125.jpg", "event-1698190074882-70266.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:27:56');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (113, 'Atwell Farm Park', '2023-04-03 00:00:00', '13:30:00', '19:30:00', 'Redditch ', 'Feed farm animals, see a wide variety of animals and large insects. There are some indoor rides and soft play. Plus giant outdoor jumping pillows. ', 'Animal and Wildlife', '["event-1698190255117-6821.jpg", "event-1698190255119-9840.jpg", "event-1698190255120-48115.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:30:56');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (114, 'Ryton Pools Country Park', '2023-06-10 00:00:00', '13:30:00', '16:00:00', 'Ryton-on-Dunsmore', 'Plenty of area to explore. Can walk or hire a bike. There is a woodland to play in and a lake.

The park has more than one children''s play area and a cafe.

The park covers 100 acres of land and the flat walking path makes it easy for buggies.', 'Nature Walks', '["event-1698190824807-82944.jpg", "event-1698190824808-93260.jpg", "event-1698190824809-71484.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:40:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (115, 'Kings Heath Park', '2023-06-11 00:00:00', '14:30:00', '18:30:00', 'Kings Heath', 'Large Park with a circular path around a grass area. Ideal for playing and cycling. Has a couple of children''s play area. Great for dog walking. There is a very small pond in some woodlands and a small cafe.

Zoe learnt to ride her bike here.', 'Parks & Garden', '["event-1698191023160-27491.jpg", "event-1698191023162-59186.jpg", "event-1698191023163-40841.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:43:44');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (116, 'Treasure Island', '2023-07-15 00:00:00', '13:30:00', '17:30:00', 'Redditch ', 'Soft play indoor for kids. Includes an indoor trampoline park.', 'Play Centres', '["event-1698191289670-19002.jpg", "event-1698191289672-2358.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:48:10');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (117, 'The Sound', '2023-07-25 00:00:00', '14:30:00', '17:45:00', 'Cregneash, Isle of Man', 'Lovely spot on the very edge of the Island to see the seals and other wildlife. Can spot the Calf of Man here and have something to eat at the cafe.', 'Nature Walks', '["event-1698191508077-99154.jpg", "event-1698191508078-33043.jpg", "event-1698191508079-69477.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:51:49');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (118, 'Peel Castle & Beach', '2023-07-27 00:00:00', '15:30:00', '18:30:00', 'Peel, Isle of Man ', 'Visited the historic Peel castle and walked along the beautiful beach. Built some sand castle and waded in the sea.', 'Day Trips', '["event-1698191651225-89789.jpg", "event-1698191651226-34139.jpg", "event-1698191651228-13790.jpg", "event-1698191651230-28311.jpg", "event-1698191651231-74824.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:54:13');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (119, 'Douglas Beach', '2023-07-28 00:00:00', '13:55:00', '16:30:00', 'Douglas, Isle of Man', 'Enjoyed the beach at Douglas and stopped at a small ice cream cafe.', 'Day Trips', '["event-1698191797343-77461.jpg", "event-1698191797344-86238.jpg", "event-1698191797346-34221.jpg", "event-1698191797347-47458.jpg"]', false, NULL, 17, NULL, '2023-10-25 06:56:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (120, 'Day Out in Birmingham & Restaurant', '2023-08-29 00:00:00', '12:30:00', '18:15:00', 'Birmingham', 'Explored Birmingham Central. Visited Europe''s biggest libary and eat at Zizi', 'Day Trips', '["event-1698192028514-48839.jpg", "event-1698192028515-3245.jpg", "event-1698192028516-90330.jpg", "event-1698192028517-68194.jpg", "event-1698192028520-25472.jpg"]', false, NULL, 17, NULL, '2023-10-25 07:00:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (121, 'Wildlife Conservation Park', '2023-08-30 00:00:00', '14:30:00', '18:00:00', 'Birmingham', 'A small zoo in Birmingham with a wide variety of animals. Theres a small restaurant, a shop and a children''s play area on site.', 'Animal and Wildlife', '["event-1698192190401-93765.jpg", "event-1698192190403-9110.jpg", "event-1698192190404-84472.jpg", "event-1698192190406-47350.jpg", "event-1698192190407-75764.jpg"]', false, NULL, 17, NULL, '2023-10-25 07:03:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (122, 'Day Trip To Weymouth Beach', '2023-09-02 00:00:00', '23:00:00', '18:30:00', 'Weymouth', 'Day trip to Weymouth beach. Enjoyed rides on the beach and various games. Attended an arcade with family games and eat at a sea side restaurant.', 'Day Trips', '["event-1698332005328-26995.jpg", "event-1698192370369-83551.jpg", "event-1698192370370-40720.jpg", "event-1698192370371-93074.jpg", "event-1698192370373-280.jpg"]', false, NULL, 17, NULL, '2023-10-25 07:06:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (123, 'Beacons Park', '2023-09-04 00:00:00', '13:30:00', '17:30:00', 'Lichfield', '70 acres of beautiful open space. There is a large children''s play area and rides for kids to enjoy. The park also has outdoor mini golf and walking path. There is a small cafe in the park.', 'Parks & Garden', '["event-1698192657508-25010.jpg"]', false, NULL, 17, NULL, '2023-10-25 07:10:10');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (124, 'Abbey Park', '2023-09-05 00:00:00', '13:00:00', '17:00:00', 'Evesham', 'An open park with a splash park. The park has a children''s play area, basket ball court, sand pit and an historic church at the other end.', 'Parks & Garden', '["event-1698193395549-3758.jpg"]', false, NULL, 17, NULL, '2023-10-25 07:15:40');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (125, 'St Nicholas Park', '2023-09-09 00:00:00', '13:30:00', '17:15:00', 'Warwick', 'Large open park with rides, a beautiful stream, large lake for water activities a splash pool and more', 'Parks & Garden', '["event-1698193113277-8881.jpg", "event-1698193113278-7365.jpg"]', false, NULL, 17, NULL, '2023-10-25 07:18:34');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (177, 'Grange Park and Playground', '2023-11-03 00:00:00', '11:00:00', '01:00:00', 'Coulsdon', 'Large open park with playground. The park also has a small cafe which sells hot drinks, ice cream, deserts and other snacks. There are toilets available.', 'Parks & Garden', '["event-1699020697044-19217.jpeg", "event-1699020697044-68838.jpeg", "event-1699020697045-82179.jpeg", "event-1699020697046-92752.jpeg", "event-1699020697046-957.jpeg"]', false, NULL, 17, NULL, '2023-11-03 21:11:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (179, 'Leamington RFC Bonfire Night ', '2023-11-05 00:00:00', '16:00:00', '19:00:00', 'Leamington ', 'Fireworks display at Leamington Spa Rugby Club. There were rides for the kids, food stand and an indoor bar to sit.

Toilets were available and everyone had a great view of the fireworks.

The display itself was about 20 mins. Entry was £20 for family of 4 (Two adults and 2 kids).', 'Family Attractions', '["event-1699367435942-69819.jpeg", "event-1699231973404-6198.jpeg", "event-1699367436296-42054.jpeg", "event-1699367436577-39021.jpeg"]', false, NULL, 17, NULL, '2023-11-06 07:52:56');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (180, 'West Midland Zoo', '2023-06-05 00:00:00', '15:25:00', '18:25:00', 'Bewdley', 'Safari and Leisure Park is a safari park located in Bewdley in Worcestershire, England. ', 'Animal and Wildlife', '["event-1699543715371-69625.jpeg", "event-1702990220646-21680.jpeg", "event-1702990220651-41703.jpeg", "event-1702990220652-85070.jpeg"]', false, NULL, 28, NULL, '2023-11-09 22:28:36');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (181, 'Worcester Park Festival', '2023-06-07 00:00:00', '09:33:00', '20:34:00', 'Worcester', 'Great day out with Mike and Sarah. Music was great, really enjoyed myself. Should''ve bought a bigger tent though.', 'Concerts', '["event-1699544064937-15703.jpeg", "event-1699544064950-23070.jpeg", "event-1699544064956-79959.jpeg"]', true, true, 28, NULL, '2023-11-09 22:34:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (182, 'British Museum', '2023-07-18 00:00:00', '15:37:00', '20:37:00', 'London', 'Day out in London visiting the sites ', 'Culture & History', '["event-1699544250317-5901.jpeg", "event-1699544250336-77614.jpeg", "event-1699544250347-83356.jpeg"]', false, false, 28, NULL, '2023-11-09 22:37:33');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (183, 'Worcester Park', '2023-06-11 00:00:00', '15:46:00', '15:47:00', 'Worcester', 'It was a nice day, so John and I took the kids to the park to enjoy the sunshine and some icecream', 'Parks & Garden', '["event-1699544843349-4257.jpeg"]', false, NULL, 29, NULL, '2023-11-09 22:47:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (184, 'Lea Valley Zoo', '2023-07-17 00:00:00', '15:50:00', '18:50:00', 'Stourbridge', 'A wonderful day out with the kids at Dudley Zoo. Lisa really liked the giraffes. After seeing the penguins, we stopped for a nice picnic and an ice cream.

The kids ended the day in the zoo playground.
', 'Animal and Wildlife', '["event-1699545034880-65969.jpeg", "event-1699545034881-61510.jpeg", "event-1720807185283-89762.jpeg"]', false, NULL, 29, NULL, '2023-11-09 22:50:35');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (185, 'Weymouth Beach', '2023-07-17 00:00:00', '16:00:00', '20:00:00', 'Dorset', 'Weekend away with John and the kids at Weymouth', 'Weekend Away', '["event-1699545677623-63316.jpeg", "event-1699545677641-12559.jpeg"]', false, NULL, 29, NULL, '2023-11-09 23:01:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (186, 'Moor Castle', '2023-07-19 00:00:00', '17:08:00', '18:09:00', 'Marystone', 'Historic castle and house in the middle of the countryside.', 'Historic Houses & Castles', '["event-1699546140740-27903.jpeg"]', false, NULL, 29, NULL, '2023-11-09 23:09:01');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (187, 'Trinity Play Centre', '2023-08-19 00:00:00', '16:10:00', '19:12:00', 'Maidhead', 'Soft lay centre for the kids to enjoy. Sace for adults to sit and a reasonably rice cafe.', 'Play Centres', '["event-1702990344143-18694.jpeg"]', false, NULL, 29, NULL, '2023-11-09 23:12:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (188, 'Aquarium', '2023-08-19 00:00:00', '16:15:00', '20:15:00', 'London', 'The Sea Life London Aquarium is located on the ground floor of County Hall on the South Bank of the River Thames in central London, near the London Eye. ', 'Animal and Wildlife', '["event-1702990322936-33647.jpeg", "event-1699546553762-7493.jpeg", "event-1699546553760-26617.jpeg"]', false, NULL, 29, NULL, '2023-11-09 23:15:54');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (189, 'Peter Hook', '2023-11-09 00:00:00', '17:20:00', '19:20:00', 'London', 'A show of Peter Hook at the local theatre', 'Theatre', '["event-1699546823445-10807.jpeg", "event-1699546823445-29609.jpeg", "event-1699546823447-80310.jpeg"]', true, true, 29, NULL, '2023-11-09 23:20:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (193, 'Joined WayzAway!', '2023-11-10 00:00:00', '13:22:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 38, NULL, '2023-11-10 20:22:01');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (194, 'We finally off to New Zealand', '2023-11-14 00:00:00', '12:34:00', '21:15:00', 'England', 'The start of our delayed 25th Wedding Anniversary Trip to New Zealand', 'Holidays', '["event-1699707561522-69862.jpeg", "event-1699979426974-65412.jpeg", "event-1699979426979-77882.jpeg", "event-1700048980527-94219.jpeg"]', false, false, 38, NULL, '2023-11-10 20:27:58');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (195, 'Joined WayzAway!', '2023-11-11 00:00:00', '13:03:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 39, NULL, '2023-11-11 20:03:04');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (196, 'Joined WayzAway!', '2023-11-11 00:00:00', '13:12:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 40, NULL, '2023-11-11 20:12:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (197, 'Joined WayzAway!', '2023-11-11 00:00:00', '14:50:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 41, NULL, '2023-11-11 21:50:48');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (199, 'Day 3 - Arrival', '2023-11-16 00:00:00', '12:05:00', '00:00:00', 'Auckland', 'The starting point of our adventure after a "Short Flight" from Blighty via Malaysia.', 'Holidays', '["event-1700119388516-92650.jpeg", "event-1700119652143-91122.jpeg", "event-1700157854992-18923.jpeg"]', false, true, 38, NULL, '2023-11-13 20:46:35');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (200, 'Day 4 - Our Road Trip Begins', '2023-11-17 00:00:00', '07:30:00', '21:29:00', 'Auckland to Rotorua', 'Lots to do first thing, collect Camper, Bikes and off to see Hobbington before arriving at our first campsite in Rotorua ', 'Holidays', '["event-1700277390407-65664.jpeg", "event-1700277583226-70345.jpeg", "event-1700277583229-24481.jpeg", "event-1700277583232-78698.jpeg", "event-1700286024189-1874.jpeg"]', false, true, 38, NULL, '2023-11-13 20:49:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (201, 'Day 5', '2023-11-18 00:00:00', '07:15:00', '22:00:00', 'Rotorua', 'Plans for today include a park run and Spa Treat', 'Holidays', '["event-1700278292298-41878.jpeg", "event-1700278458409-72034.jpeg", "event-1700278458411-60971.jpeg", "event-1700278576396-13312.jpeg", "event-1700286680263-97296.jpeg"]', false, true, 38, NULL, '2023-11-13 20:51:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (203, 'Joined WayzAway!', '2023-11-14 00:00:00', '12:03:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 43, NULL, '2023-11-14 19:03:19');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (204, 'Joined WayzAway!', '2023-11-14 00:00:00', '18:44:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 44, NULL, '2023-11-15 01:44:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (205, 'Play Opera Live', '2023-11-11 00:00:00', '15:00:00', '17:30:00', 'Birmingham', 'Went to Birmingham Hippodrome theatre to watch the Welsh National Opera. 

Before the show kids could get face painted', 'Theatre', '["event-1700218469758-40238.jpeg", "event-1700218469765-83508.jpeg", "event-1700218470172-72939.jpeg"]', false, NULL, 17, NULL, '2023-11-17 17:54:31');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (206, 'Extra Photos', '2023-11-19 00:00:00', '09:00:00', '22:01:00', 'New Zealand', 'Random Photos', 'Holidays', '["event-1700288150899-83568.jpeg", "event-1700288150903-78521.jpeg", "event-1700288150906-41767.jpeg", "event-1700288150917-8992.jpeg", "event-1700288151031-15018.jpeg"]', false, NULL, 38, NULL, '2023-11-18 13:02:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (207, 'Joined WayzAway!', '2023-11-18 00:00:00', '07:40:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 45, NULL, '2023-11-18 14:40:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (208, 'Day-6 Huka Falls Bike Ride', '2023-11-19 00:00:00', '00:00:00', '00:00:00', 'Huka Falls', 'Time to break the bikes in,  and Nikki on a simple 16k route', 'Holidays', '["event-1700464079695-1486.jpeg", "event-1700463460347-76509.jpeg", "event-1700463460352-90474.jpeg", "event-1700464160342-65891.jpeg", "event-1700464209288-67716.jpeg"]', false, NULL, 38, NULL, '2023-11-19 15:01:33');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (209, 'Day-7 Napier', '2023-11-20 00:00:00', '10:00:00', '00:00:00', 'Napier', 'On to Napier', 'Holidays', '["event-1700464910575-13247.jpeg", "event-1700464991602-15903.jpeg", "event-1700464991603-77887.jpeg", "event-1700464991604-72064.jpeg"]', false, NULL, 38, NULL, '2023-11-19 15:04:15');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (210, 'Day-5 & 6 Lake Taupo', '2023-11-19 00:00:00', '08:00:00', '23:59:00', 'Lake Taupo', '2 nights at Lake Taupo', 'Holidays', '["event-1700464410218-43070.jpeg", "event-1700464702174-69445.jpeg", "event-1700464702177-62851.jpeg"]', false, NULL, 38, NULL, '2023-11-20 14:13:31');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (211, 'Day-8 Napier to Martinborough', '2023-11-21 00:00:00', '09:00:00', '00:00:00', 'Martinborough', 'Road trip to Martinborough via Waiki Falls', 'Holidays', '["event-1700724973175-53569.jpeg"]', false, NULL, 38, NULL, '2023-11-20 14:27:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (212, 'Day-9 Martinborough to Wellington', '2023-11-22 00:00:00', '09:00:00', '23:55:00', 'Wellington', 'Our journey on North NZ Mars an end. Last stop Wellington before the ferry to Picton', 'Holidays', '["event-1700724676921-2114.jpeg"]', false, NULL, 38, NULL, '2023-11-23 14:31:17');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (213, 'North to South Island', '2023-11-22 00:00:00', '16:00:00', '19:30:00', 'New Zealand', 'Ferry crossing from Wellington to Picton', 'Holidays', '["event-1700725339709-9753.jpeg", "event-1700727975910-23989.jpeg"]', false, NULL, 38, NULL, '2023-11-23 14:42:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (214, 'Day-10 Picton to Spring Creek', '2023-11-23 00:00:00', '09:00:00', '23:55:00', 'New Zealand South Island', 'Scenic route via Queen Charlotte drive from Picton, via Havelok, Renwick and Blenhiem. Wine country and sight seeing.', 'Holidays', '["event-1700728323101-31778.jpeg", "event-1700728534490-72158.jpeg", "event-1700728534491-8054.jpeg", "event-1700728534493-92575.jpeg"]', false, NULL, 38, NULL, '2023-11-23 15:32:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (215, 'Day-11 Road trip to Kiakoura', '2023-11-24 00:00:00', '09:00:00', '23:55:00', 'New Zealand South Island', 'Leisurely Road trip along the coast. ', 'Holidays', '[]', false, NULL, 38, NULL, '2023-11-23 15:38:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (217, 'Joined WayzAway!', '2023-11-24 00:00:00', '14:15:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 46, NULL, '2023-11-24 21:15:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (218, 'Joined WayzAway!', '2023-11-27 00:00:00', '14:26:00', NULL, 'Ukraine', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 47, NULL, '2023-11-28 12:26:37');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (219, 'Joined WayzAway!', '2023-11-27 00:00:00', '11:33:00', NULL, 'Sri Lanka', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 48, NULL, '2023-11-28 13:03:13');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (220, 'Joined WayzAway!', '2023-11-27 00:00:00', '11:51:00', NULL, 'India', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, true, 49, NULL, '2023-11-28 13:21:10');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (221, 'Joined WayzAway!', '2023-11-28 00:00:00', '09:24:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 50, NULL, '2023-11-28 16:24:46');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (222, 'Holiday', '2023-12-26 00:00:00', '12:30:00', '09:26:00', 'Waterford ', 'Driving home for xmas', 'Holidays', '[]', false, NULL, 50, NULL, '2023-11-28 16:26:36');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (223, 'Crazy Golf', '2023-11-25 00:00:00', '12:30:00', '17:30:00', 'Birmingham Star City', 'Crazy golf for the family. 18 holes. Followed by arcade', 'Indoor Activities', '["event-1701730522080-69431.jpeg", "event-1701730444391-69189.jpeg", "event-1701730444394-70336.jpeg"]', false, NULL, 17, NULL, '2023-12-05 05:54:06');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (224, 'Thai Express', '2023-12-06 00:00:00', '12:30:00', '13:30:00', 'Birmingham', 'Thai restaurant in Birmingham Grand Central.

', 'Food & Drinks', '["event-1701871800866-49053.jpeg", "event-1701871800888-41993.jpeg", "event-1701871801330-16089.jpeg"]', false, NULL, 17, NULL, '2023-12-06 21:10:04');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (225, 'Joined WayzAway!', '2023-12-11 00:00:00', '14:47:00', NULL, 'France', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 51, NULL, '2023-12-12 20:47:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (226, 'Test', '2023-12-12 00:00:00', '15:00:00', '18:00:00', 'Ifs', 'Lorem ipsum', 'Tours', '[]', false, NULL, 51, NULL, '2023-12-12 20:48:16');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (227, 'Becketts Farm', '2023-12-09 00:00:00', '12:00:00', '16:30:00', 'Birmingham', 'Farm shop and restaurant.

Zoe went to Ayanna''s birthday party and we stopped at the shop and restaurant.', 'Food & Drinks', '["event-1702477913221-23238.jpeg"]', false, NULL, 17, NULL, '2023-12-13 21:31:54');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (228, 'Cocks Moors Swimming', '2023-12-10 00:00:00', '16:00:00', '18:00:00', 'Birmingham', 'Gabriel''s swimming birthday party', 'Indoor Activities', '["event-1702477999048-95431.jpeg"]', false, false, 17, NULL, '2023-12-13 21:33:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (245, 'Seaside', '2023-12-19 00:00:00', '12:48:00', '12:48:00', 'Brighton', 'Beach Day', 'Animal and Wildlife', '["event-1702990126573-11273.jpeg", "event-1702990190073-73671.jpeg"]', false, NULL, 28, NULL, '2023-12-19 19:48:48');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (247, 'Joined WayzAway!', '2023-12-21 00:00:00', '02:10:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 56, NULL, '2023-12-21 09:10:23');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (248, 'Joined WayzAway!', '2023-12-21 00:00:00', '17:27:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 57, NULL, '2023-12-22 00:27:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (249, 'Knowle Locks', '2023-12-16 00:00:00', '15:30:00', '17:30:00', 'Solihull', 'Beautiful Walk along a canal in the country side', 'Nature Walks', '["event-1703306584595-59953.jpeg", "event-1703306772967-19045.jpeg", "event-1703306772968-31258.jpeg", "event-1703306772985-73861.jpeg", "event-1703306773018-49344.jpeg"]', false, NULL, 17, NULL, '2023-12-23 11:43:05');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (250, 'Birmingham German Market', '2023-12-21 00:00:00', '16:30:00', '19:30:00', 'Birmingham Central', 'Went for a meal at Nandos then stopped at the German market', 'Food & Drinks', '["event-1703307133356-93436.jpeg", "event-1703307011488-36623.jpeg", "event-1703307011864-78701.jpeg", "event-1703307012089-82041.jpeg", "event-1703307133374-65611.jpeg"]', false, NULL, 17, NULL, '2023-12-23 11:50:14');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (251, 'Joined WayzAway!', '2023-12-24 00:00:00', '17:01:00', NULL, 'United States', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 58, NULL, '2023-12-25 06:01:31');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (252, 'Priory Park', '2023-12-26 00:00:00', '14:00:00', '17:30:00', 'Reigate', 'Large open space park with walking path, skate park, children''s play area and a food stall', 'Parks & Garden', '["event-1703638063673-60593.jpeg", "event-1703638064088-79964.jpeg", "event-1703638064090-93056.jpeg", "event-1703638064090-72578.jpeg", "event-1703638064225-78504.jpeg"]', false, NULL, 17, NULL, '2023-12-27 07:47:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (253, 'Kinver Edge Rock Houses', '2023-10-28 00:00:00', '12:30:00', '17:30:00', 'Kinver', 'Kinver Edge is home to the last troglodyte dwellings occupied in England, with a set of complete cave-houses excavated into the local sandstone. It''s owned by the National Trust. There''s a lovely cafe and it''s sorrounded by hills, great for walking.', 'Historic Houses & Castles', '["event-1703638434338-30488.jpeg", "event-1703638434361-5873.jpeg", "event-1703638434377-45186.jpeg", "event-1703638434445-74522.jpeg", "event-1703638434576-93594.jpeg"]', false, NULL, 17, NULL, '2023-12-27 07:53:56');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (254, 'Joined WayzAway!', '2023-12-26 00:00:00', '10:20:00', NULL, 'Australia', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 59, NULL, '2023-12-27 15:20:47');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (256, 'Joined WayzAway!', '2023-12-28 00:00:00', '09:48:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 60, NULL, '2023-12-28 16:48:55');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (257, 'Joined WayzAway!', '2023-12-27 00:00:00', '17:50:00', NULL, 'India', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 61, NULL, '2023-12-28 16:50:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (258, 'Joined WayzAway!', '2023-12-27 00:00:00', '11:52:00', NULL, 'Romania', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 62, NULL, '2023-12-28 16:52:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (259, 'Joined WayzAway!', '2023-12-27 00:00:00', '14:14:00', NULL, 'South Africa', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 63, NULL, '2023-12-28 17:14:06');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (260, 'Joined WayzAway!', '2023-12-28 00:00:00', '10:18:00', NULL, 'Belgium', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 64, NULL, '2023-12-28 17:18:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (261, 'Joined WayzAway!', '2023-12-27 00:00:00', '11:28:00', NULL, 'Belgium', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 65, NULL, '2023-12-28 17:28:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (262, 'Joined WayzAway!', '2023-12-27 00:00:00', '22:10:00', NULL, 'Australia', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 66, NULL, '2023-12-28 18:10:05');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (263, 'Joined WayzAway!', '2023-12-28 00:00:00', '11:21:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 67, NULL, '2023-12-28 18:21:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (264, 'Joined WayzAway!', '2023-12-28 00:00:00', '11:36:00', NULL, 'Sweden', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 68, NULL, '2023-12-28 18:36:01');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (265, 'Joined WayzAway!', '2023-12-28 00:00:00', '07:08:00', NULL, 'Jamaica', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 69, NULL, '2023-12-28 19:08:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (266, 'Joined WayzAway!', '2023-12-28 00:00:00', '12:14:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 70, NULL, '2023-12-28 19:14:36');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (267, 'Joined WayzAway!', '2023-12-27 00:00:00', '13:19:00', NULL, 'Austria', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 71, NULL, '2023-12-28 19:19:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (268, 'Joined WayzAway!', '2023-12-27 00:00:00', '14:37:00', NULL, 'Finland', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 72, NULL, '2023-12-28 19:37:35');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (269, 'Joined WayzAway!', '2023-12-28 00:00:00', '09:14:00', NULL, 'United States', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 73, NULL, '2023-12-28 21:14:36');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (270, 'Joined WayzAway!', '2023-12-28 00:00:00', '14:01:00', NULL, 'Canada', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 74, NULL, '2023-12-29 05:01:48');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (271, 'Joined WayzAway!', '2023-12-29 00:00:00', '15:45:00', NULL, 'Canada', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 75, NULL, '2023-12-30 03:45:08');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (276, 'Christmas 2023', '2023-12-24 00:00:00', '16:00:00', '00:00:00', 'Toronto', 'Spending Christmas with family. My mom, my dad, my sister and her daughter, my husband and my daughters, my cousin', 'Holidays', '["event-1703883215936-34706.jpeg", "event-1703883215942-1015.jpeg", "event-1703883215952-81377.jpeg", "event-1703883215959-17571.jpeg", "event-1703883215972-12755.jpeg"]', false, NULL, 75, NULL, '2023-12-30 03:53:37');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (277, 'Christmas 2023', '2023-12-25 00:00:00', '00:00:00', '14:30:00', 'Coulsdon', 'Spent Christmas with the family in London', 'Holidays', '["event-1703887637629-71763.jpeg", "event-1703887598420-48243.jpeg", "event-1703887745382-9313.jpeg", "event-1703887745382-5277.jpeg", "event-1703887745383-45753.jpeg"]', false, NULL, 17, NULL, '2023-12-30 05:06:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (278, 'Pre-Christmas Meal', '2023-12-23 00:00:00', '16:00:00', '21:30:00', 'Bromley', 'Meal and family get together at our sister''s house', 'Holidays', '["event-1703887975014-50220.jpeg", "event-1703887933821-6524.jpeg", "event-1703887904553-46937.jpeg", "event-1703887904554-11448.jpeg", "event-1703887975014-75059.jpeg"]', false, NULL, 17, NULL, '2023-12-30 05:11:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (279, 'Travel to Winslet Manor', '2024-01-04 00:00:00', '17:45:00', '22:45:00', 'Isle of Wight', 'Memorable day out', 'Culture & History', '["event-1704160125194-94620.jpeg"]', false, NULL, 29, NULL, '2024-01-02 08:42:51');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (284, 'Chase valley Park', '2023-01-17 00:00:00', '02:13:00', '02:13:00', 'Elmsley', 'Park Day', 'Parks & Garden', '["event-1704161667752-45110.jpeg"]', false, NULL, 77, NULL, '2024-01-02 09:14:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (285, 'Bon Jova', '2024-01-10 00:00:00', '02:20:00', '02:22:00', 'Leicester', 'Eat Out', 'Food & Drinks', '["event-1704162200758-83740.jpeg"]', false, NULL, 76, NULL, '2024-01-02 09:23:21');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (286, '2024 New Year at Isle of Man', '2024-01-01 00:00:00', '00:00:00', '21:00:00', 'Peel', 'Spent New years with family at Isle of Man. Played party games ', 'Holidays', '["event-1704529319049-35532.jpeg", "event-1704529319051-10002.jpeg", "event-1704529319053-66289.jpeg", "event-1704529319059-10731.jpeg", "event-1704529319061-74255.jpeg"]', false, false, 17, NULL, '2024-01-06 15:21:59');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (465, 'Joined WayzAway!', '2024-07-14 00:00:00', '17:24:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 190, NULL, '2024-07-15 16:24:51');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (287, 'Steph''s 38th at Laxey', '2024-01-06 00:00:00', '15:00:00', '00:00:00', 'Isle of Man', 'Day trip to Laxey for stephs birthday', 'Day Trips', '["event-1704529748964-58898.jpeg", "event-1704529624266-8819.jpeg", "event-1704529624432-89255.jpeg", "event-1704529624785-57915.jpeg", "event-1704529625132-25417.jpeg"]', false, NULL, 17, NULL, '2024-01-06 15:27:06');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (288, 'La Mona lisa', '2024-01-03 00:00:00', '19:15:00', '21:30:00', 'Laxey', 'Italian restaurant in laxey.', 'Food & Drinks', '["event-1704530018665-4278.jpeg", "event-1704530018687-15870.jpeg", "event-1704530018700-96842.jpeg"]', false, false, 17, NULL, '2024-01-06 15:33:40');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (289, 'Peel Evening Walk', '2024-01-04 00:00:00', '18:30:00', '20:30:00', 'Isle of Man', 'Evening walk in Peel', 'Outdoor Activities', '["event-1704530318657-35719.jpeg", "event-1704530318674-57831.jpeg", "event-1704530318686-95385.jpeg", "event-1704530318883-67673.jpeg", "event-1704530318894-60361.jpeg"]', false, NULL, 17, NULL, '2024-01-06 15:38:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (290, 'Kirk Michael Beach', '2024-01-06 00:00:00', '15:30:00', '17:30:00', 'Isle of Man', 'Walk on the beach', 'Nature Walks', '["event-1704530593504-60110.jpeg", "event-1704530593519-92013.jpeg", "event-1704530593532-99164.jpeg", "event-1704530593545-8160.jpeg", "event-1704530593553-16585.jpeg"]', false, NULL, 17, NULL, '2024-01-06 15:43:15');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (291, 'Boat back home', '2024-01-06 00:00:00', '08:00:00', '11:00:00', 'Manx Man', 'On the new boat back home', 'Adventure Activities', '["event-1704566028355-59096.jpeg", "event-1704530694245-49060.jpeg", "event-1704530694255-71088.jpeg", "event-1704566028357-24040.jpeg", "event-1704566028358-12414.jpeg"]', false, false, 17, NULL, '2024-01-06 15:44:55');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (292, 'Upton House Gardens', '2024-01-13 00:00:00', '13:30:00', '17:30:00', 'Banbury', 'Upton House is a country house in the civil parish of Ratley and Upton, in the English county of Warwickshire. 

Lord Bearsted donated the house, gardens and art collection to the National Trust in 1948.

There is a large woodland walk, a beautiful lake and plenty of open greens for kids to run around. The place also has a cosy cafe that sells sandwiches, cakes, hot food and hot drinks.', 'Historic Houses & Castles', '["event-1705327087323-88236.jpeg", "event-1705327087345-99376.jpeg", "event-1705327087946-81793.jpeg", "event-1705327087947-95534.jpeg", "event-1705327087952-72501.jpeg"]', false, NULL, 17, NULL, '2024-01-15 20:58:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (294, 'Little Tinkers', '2024-01-15 00:00:00', '13:15:00', '14:30:00', 'Birmingham', 'Sensory play centre for little babies.

We took Isabel for about an hour', 'Indoor Activities', '["event-1705397188342-52961.jpeg", "event-1705397188342-79350.jpeg", "event-1705397188343-13444.jpeg", "event-1705397188344-60413.jpeg", "event-1705397188345-10170.jpeg"]', false, false, 17, NULL, '2024-01-16 16:26:29');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (297, 'Black Country Museum', '2024-01-27 00:00:00', '13:10:00', '16:20:00', 'Dudley', 'Winter visit to black country museum and coal mines. Zoe''s friend, Daniel joined us', 'Museums & Exhibitions', '["event-1706403795101-10095.jpeg", "event-1706403795125-69842.jpeg", "event-1706403795292-62646.jpeg", "event-1706403795374-41815.jpeg", "event-1706403795942-57893.jpeg"]', false, NULL, 17, NULL, '2024-01-28 08:03:18');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (298, 'Joined WayzAway!', '2024-01-31 00:00:00', '12:08:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 87, NULL, '2024-02-01 13:38:55');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (299, 'Q Bar & Kitchen', '2024-02-03 00:00:00', '10:30:00', '12:30:00', 'Beckenham', 'Breakfast at Q Bar for Lekan''s birthday. Spent time with Sister, brother wife and kids.
', 'Food & Drinks', '["event-1707097606607-74657.jpeg", "event-1707097606610-28985.jpeg", "event-1707097606612-34720.jpeg", "event-1707097606617-67935.jpeg", "event-1707097606618-13189.jpeg"]', false, NULL, 17, NULL, '2024-02-05 08:46:46');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (300, 'Canon Hill Park', '2024-02-04 00:00:00', '16:30:00', '18:00:00', 'Birmingham ', 'Evening Winter walk. Simi got to ride her bike', 'Parks & Garden', '["event-1707097760154-60241.jpeg", "event-1707097733463-73197.jpeg", "event-1707097733466-43022.jpeg", "event-1707097760155-69064.jpeg", "event-1707097733469-90874.jpeg"]', false, NULL, 17, NULL, '2024-02-05 08:48:53');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (301, 'Hickory Dickory', '2024-02-05 00:00:00', '11:30:00', '12:30:00', 'Birmingham ', 'Isabel first time playing at Hickory Dickory', 'Play Centres', '["event-1707143678295-48596.jpeg", "event-1707143678313-19351.jpeg"]', false, NULL, 17, NULL, '2024-02-05 21:34:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (302, 'Hazelwell Pub', '2024-02-16 00:00:00', '13:00:00', '14:30:00', 'Stirchley', 'Friday afternoon lunch with nan', 'Food & Drinks', '["event-1708167651003-47690.jpeg", "event-1708167651006-3721.jpeg", "event-1708167651009-64586.jpeg", "event-1708167651012-26664.jpeg"]', false, NULL, 17, NULL, '2024-02-17 18:00:51');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (303, 'Northern Ireland', '2024-02-18 00:00:00', '11:00:00', '15:30:00', 'Ballyclare', 'Steph goes to Wendy''s at N.Ireland for work', 'Holidays', '["event-1708286070179-19251.jpeg", "event-1708286070182-38286.jpeg", "event-1708286070183-51292.jpeg"]', false, NULL, 17, NULL, '2024-02-19 02:54:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (304, 'Carrick-a-Rede', '2024-02-18 00:00:00', '16:30:00', '17:50:00', 'Ballintoy', 'Steph visited a rope bridge that was first erected by salmon fishermen in 1755. The name, from the Gaelic ''Carraig-a-Rade'', means ''The Rock in the Road''. It''s part of the National Trust. It''s one of Northern Irelands most popular tourist destination.', 'Landmarks & Monuments', '["event-1708286574006-89395.jpeg", "event-1708286547267-6890.jpeg", "event-1708286547267-46355.jpeg", "event-1708286547270-3179.jpeg", "event-1708286574007-13425.jpeg"]', false, NULL, 17, NULL, '2024-02-19 03:02:27');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (305, 'Belfast ', '2024-02-19 00:00:00', '18:30:00', '20:30:00', 'N.Ireland', 'Steph went out for drinks with work friends in Belfast ', 'Food & Drinks', '["event-1708403407489-40908.jpeg", "event-1708805386159-37126.jpeg"]', false, NULL, 17, NULL, '2024-02-20 11:30:07');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (306, 'F1', '2024-02-25 00:00:00', '16:00:00', '19:30:00', 'Birmingham', 'Formula one racing bar for Wes'' 30th', 'Food & Drinks', '["event-1708905265507-73403.jpeg", "event-1708905265526-11473.jpeg", "event-1708905265529-2710.jpeg", "event-1708905265533-98312.jpeg", "event-1708905265534-9415.jpeg"]', false, NULL, 17, NULL, '2024-02-26 06:54:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (307, 'Joined WayzAway!', '2024-03-02 00:00:00', '05:49:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 88, NULL, '2024-03-02 12:49:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (308, 'Sanders Park', '2024-03-03 00:00:00', '16:00:00', '18:30:00', 'Bromsgrove', 'Bike riding for muddy Zoe and a walk around Sanders. ', 'Parks & Garden', '["event-1709767277287-28009.jpeg", "event-1709767277289-22671.jpeg", "event-1709767277291-83849.jpeg", "event-1709767277294-83695.jpeg", "event-1709767277297-78219.jpeg"]', false, NULL, 17, NULL, '2024-03-07 06:21:17');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (311, 'Mary Stevens Park', '2024-03-17 00:00:00', '17:30:00', '18:40:00', 'Stourbridge', 'The family went for a Sunday evening walk and bike ride. Zoe rode her bike and stopped to play in the playground.', 'Parks & Garden', '["event-1710727099100-82792.jpeg", "event-1710727099101-47031.jpeg", "event-1710727099120-53546.jpeg", "event-1710727099123-6767.jpeg", "event-1710727099124-11831.jpeg"]', false, NULL, 17, NULL, '2024-03-18 08:58:19');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (312, 'Joined WayzAway!', '2024-03-18 00:00:00', '10:32:00', NULL, 'United Kingdom', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 91, NULL, '2024-03-19 12:02:06');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (313, 'Rush ', '2024-03-23 00:00:00', '15:30:00', '18:30:00', 'Birmingham', 'Fun playhouse for kids. Trampoline and bounce area', 'Play Centres', '["event-1711223788749-67701.jpeg", "event-1711223788750-69353.jpeg", "event-1711223788751-60080.jpeg", "event-1711223788753-48189.jpeg", "event-1711223788755-58271.jpeg"]', false, NULL, 17, NULL, '2024-03-24 02:56:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (314, 'Kings Norton Park', '2024-03-23 00:00:00', '18:30:00', '19:00:00', 'Birmingham', 'Stopped at King''s Norton Park and the kids used the playground. Anu went on her first swing.', 'Parks & Garden', '["event-1711223976416-57121.jpeg", "event-1711223976417-36163.jpeg", "event-1711223976450-9623.jpeg", "event-1711223977142-31369.jpeg", "event-1711223977522-19617.jpeg"]', false, NULL, 17, NULL, '2024-03-24 02:59:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (315, 'Spring into sculpture event', '2024-03-24 00:00:00', '15:15:00', '18:30:00', 'Birmingham', 'Alice in wonderland theme in Moseley Park. Fun activities and story time for toddlers', 'Parks & Garden', '["event-1711321275826-65355.jpeg", "event-1711321275826-84092.jpeg", "event-1711321275827-17625.jpeg", "event-1711311634354-15339.jpeg", "event-1711311634355-86402.jpeg"]', false, NULL, 17, NULL, '2024-03-25 03:20:34');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (316, 'Moseley Park', '2024-03-24 00:00:00', '15:30:00', '18:30:00', 'Birmingham', 'Walk in Moseley Park and around the lake.', 'Parks & Garden', '["event-1711320909459-50360.jpeg", "event-1711320909685-67271.jpeg", "event-1711320909813-98317.jpeg", "event-1711320910558-81119.jpeg", "event-1711320910940-22691.jpeg"]', false, NULL, 17, NULL, '2024-03-25 05:55:13');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (317, 'JAQKS Restaurant', '2024-03-24 00:00:00', '18:00:00', '19:00:00', 'Birmingham', 'Chips and chicken. Serves very large portion. In the heart of Moseley.', 'Food & Drinks', '["event-1711321174865-75152.jpeg", "event-1711321174879-41479.jpeg", "event-1711321125386-91121.jpeg"]', false, NULL, 17, NULL, '2024-03-25 05:58:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (318, 'Malvern Park', '2024-03-30 00:00:00', '17:00:00', '18:15:00', 'Solihull', 'Nice Park in middle of Solihull and linked to Brueton. Great for walking cycling.

Has a playground and tennis court.', 'Parks & Garden', '["event-1711843513153-83351.jpeg", "event-1711843465809-88071.jpeg", "event-1711843513167-97741.jpeg", "event-1711843466340-7452.jpeg", "event-1711843467014-44782.jpeg"]', false, NULL, 17, NULL, '2024-03-31 07:04:29');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (319, 'Hickory Dickory', '2024-03-30 00:00:00', '14:00:00', '16:00:00', 'Birmingham', 'Zoe went for Matteo''s 6th birthday party', 'Play Centres', '["event-1711843720643-84525.jpeg", "event-1711843720644-66194.jpeg"]', false, NULL, 17, NULL, '2024-03-31 07:08:14');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (320, 'Easter Egg Hunt', '2024-03-31 00:00:00', '15:00:00', '18:00:00', 'Moseley', 'Easter egg hunt and walka around the lake at Moseley park with Nan', 'Parks & Garden', '["event-1711919755929-67071.jpeg", "event-1711919755932-3166.jpeg", "event-1711919755938-57581.jpeg", "event-1711919755941-63082.jpeg", "event-1711919947927-13912.jpeg"]', false, NULL, 17, NULL, '2024-04-01 04:15:56');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (322, 'Becketts Farm & Aquatics', '2024-04-01 00:00:00', '14:30:00', '16:00:00', 'Birmingham', 'Visited Becketts farm shop and Shirley Aquatics. Fed some Koi fishes and saw some reptiles and a small shark.', 'Indoor Activities', '["event-1711994708651-36032.jpeg", "event-1711994708797-53195.jpeg", "event-1711994709158-39804.jpeg", "event-1711994709289-736.jpeg", "event-1711994709301-34829.jpeg"]', false, NULL, 17, NULL, '2024-04-02 01:05:11');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (323, 'Kingsbury Water Park', '2024-04-06 00:00:00', '15:30:00', '18:00:00', 'Sutton Coldfield', 'Park with a large lake. Went for a bike ride and long walk around the lake', 'Parks & Garden', '["event-1712436581910-11777.jpeg", "event-1712436582135-68657.jpeg", "event-1712436582509-83196.jpeg", "event-1712436582984-68435.jpeg", "event-1712436583464-45149.jpeg"]', false, NULL, 17, NULL, '2024-04-07 03:49:46');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (324, 'Joined WayzAway!', '2024-04-09 00:00:00', '18:22:00', NULL, 'France', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 94, NULL, '2024-04-10 23:22:54');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (325, 'Matilda', '2024-04-13 00:00:00', '11:00:00', '12:30:00', 'Mac - Birmingham', 'Matilda musical at Mac Birmingham. Produced by Riverside Church featuring Daniel''s sister.', 'Theatre', '["event-1713050731107-89986.jpeg", "event-1713050731131-16859.jpeg", "event-1713050731525-90813.jpeg", "event-1713050731626-30816.jpeg", "event-1713050732002-84418.jpeg"]', false, NULL, 17, NULL, '2024-04-14 06:25:34');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (328, 'Joined WayzAway!', '2024-04-16 00:00:00', '18:53:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 96, NULL, '2024-04-18 00:53:06');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (329, 'Joined WayzAway!', '2024-04-18 00:00:00', '18:37:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 97, NULL, '2024-04-19 23:37:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (330, 'Athena''s party', '2024-04-21 00:00:00', '03:45:00', '05:45:00', 'Cocks Moors Woods', 'Zoe attended Athenas 6th  birthday party - inflatables', 'Play Centres', '["event-1713696817172-67240.jpeg", "event-1713696817186-38978.jpeg", "event-1713696817193-83310.jpeg"]', false, NULL, 17, NULL, '2024-04-21 17:53:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (331, 'Joined WayzAway!', '2024-04-20 00:00:00', '22:44:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 98, NULL, '2024-04-22 03:44:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (333, 'Joined WayzAway!', '2024-04-24 00:00:00', '14:52:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 100, NULL, '2024-04-25 19:52:31');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (334, 'Spain', '2024-04-07 00:00:00', '14:53:00', '17:54:00', 'Andalucia', 'This was it!', 'Culture & History', '["event-1714049705394-45089.jpeg", "event-1714049705471-48446.jpeg", "event-1714049705850-56098.jpeg", "event-1714049706182-14310.jpeg", "event-1714049706565-85766.jpeg"]', false, NULL, 100, NULL, '2024-04-25 19:55:08');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (335, 'Joined WayzAway!', '2024-04-24 00:00:00', '15:26:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 101, NULL, '2024-04-25 21:26:34');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (336, 'Joined WayzAway!', '2024-04-27 00:00:00', '08:45:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 102, NULL, '2024-04-28 06:45:15');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (337, 'Palm Springs', '2024-05-13 00:00:00', '08:46:00', '08:46:00', 'Palm Springs California', 'Tennis', 'Adventure Activities', '[]', false, NULL, 102, NULL, '2024-04-28 06:46:46');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (338, 'Joined WayzAway!', '2024-04-27 00:00:00', '17:23:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 103, NULL, '2024-04-28 22:23:52');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (340, 'Joined WayzAway!', '2024-04-29 00:00:00', '16:40:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 105, NULL, '2024-04-30 03:40:53');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (341, 'Nora''s Birthday', '2024-04-21 00:00:00', '13:30:00', '15:30:00', 'Humpty Dumpty', 'Zoe and Isabel attended Nora''s birthday party at Humpty Dumpty indoor play centre.', 'Indoor Activities', '["event-1714463555665-78953.jpeg", "event-1714463555985-17381.jpeg", "event-1714463555998-91341.jpeg"]', false, NULL, 17, NULL, '2024-04-30 14:52:37');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (342, 'Zoe 6th Birthday Party', '2024-04-30 00:00:00', '13:00:00', '15:30:00', 'Rush', 'Zoe birthday party. Jumping around in Rush followed by a food, cake and drinks with her friends. ', 'Indoor Activities', '["event-1714463858749-73288.jpeg", "event-1714463858749-11563.jpeg", "event-1714463858751-37270.jpeg", "event-1714463858753-22905.jpeg", "event-1714463858754-19000.jpeg"]', false, NULL, 17, NULL, '2024-04-30 14:57:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (343, 'Joined WayzAway!', '2024-04-30 00:00:00', '20:17:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 106, NULL, '2024-05-02 01:17:02');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (344, 'Joined WayzAway!', '2024-05-03 00:00:00', '16:59:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 107, NULL, '2024-05-04 20:59:08');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (345, 'KH Park- after school play', '2024-05-09 00:00:00', '18:00:00', '19:00:00', 'Kings Heath Park', 'Took Isla and Zo for a bike ride round the park', 'Parks & Garden', '["event-1715278147483-96182.jpeg", "event-1715278161765-68439.jpeg", "event-1715278169277-59959.jpeg", "event-1715278186470-20229.jpeg", "event-1715278306996-33000.jpeg"]', false, NULL, 17, NULL, '2024-05-10 01:07:16');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (346, 'Evening walk with Linz and Nikita', '2024-05-10 00:00:00', '08:30:00', '21:30:00', 'Rowheath', 'Parked at Nikitas. Walked round Rowheath and nearby avenues with pretty houses. Minor scare with leaf chasing us. ', 'Nature Walks', '["event-1715327525791-9455.jpeg", "event-1715327555267-71660.jpeg"]', false, NULL, 17, NULL, '2024-05-10 14:52:06');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (348, 'Joined WayzAway!', '2024-05-12 00:00:00', '13:13:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 108, NULL, '2024-05-13 10:13:31');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (349, 'Luxury cruise ', '2024-05-20 00:00:00', '15:30:00', '13:15:00', 'Southern France &Italy', '14 day cruise ', 'Holidays', '[]', false, NULL, 108, NULL, '2024-05-13 10:15:58');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (350, 'Playland Fun Park', '2024-05-11 00:00:00', '12:30:00', '17:30:00', 'Stourport', 'Went to playland with nan. Zoe and Isabel enjoyed the rides including the larger ones in Treasure Island. We finished the day in the grass enjoying a picnic and playing with the ball.', 'Outdoor Activities', '["event-1715597656666-88031.jpeg", "event-1715597658475-84828.jpeg", "event-1715597661146-99341.jpeg", "event-1715597663305-76355.jpeg", "event-1715597665195-50088.jpeg"]', false, NULL, 17, NULL, '2024-05-13 17:54:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (351, 'Zoe Ballet and Weatherspoon', '2024-05-12 00:00:00', '10:30:00', '16:30:00', 'Birmingham', 'Zoe went to a ballet dance workshop with mum, nan and Isabel. After, we stopped at Weatherspoon for a meal. Then Zoe got her ears pierced for the first time.', 'Day Trips', '["event-1715598249418-87783.jpeg", "event-1715597992233-50066.jpeg", "event-1715597995581-47458.jpeg", "event-1715598251100-43128.jpeg", "event-1715598305753-97352.jpeg"]', false, NULL, 17, NULL, '2024-05-13 17:59:59');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (352, 'Upton Farm', '2024-05-16 00:00:00', '10:15:00', '16:00:00', 'Banbury', 'Sheep and cattle grazing on the extensive grassland, that covers the many steep banks as well as the historic parkland at Upton.', 'Animal and Wildlife', '["event-1715860458922-8870.jpeg", "event-1715860459598-64028.jpeg"]', true, NULL, 77, NULL, '2024-05-16 18:54:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (355, 'Joined WayzAway!', '2024-05-18 00:00:00', '20:14:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 109, NULL, '2024-05-19 10:14:04');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (358, 'Joined WayzAway!', '2024-05-21 00:00:00', '21:33:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 111, NULL, '2024-05-23 02:33:58');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (359, 'Joined WayzAway!', '2024-05-22 00:00:00', '13:49:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 112, NULL, '2024-05-23 18:49:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (360, 'Japan 2024', '2024-06-02 00:00:00', '00:00:00', '23:59:00', 'Japan', 'Holiday trip to Japan', 'Holidays', '[]', false, NULL, 112, NULL, '2024-05-23 18:51:06');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (361, 'Joined WayzAway!', '2024-05-23 00:00:00', '00:02:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 113, NULL, '2024-05-24 05:02:05');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (369, 'Isabel''s 1st Birthday', '2024-05-18 00:00:00', '00:00:00', '23:59:00', 'London', 'Celebrated Anu 1st birthday with family in London. Had food delivered to the house.', 'General', '["event-1716852405130-1395.jpeg", "event-1716852405289-99764.jpeg", "event-1716852405544-55262.jpeg"]', false, NULL, 17, NULL, '2024-05-28 06:26:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (370, 'Rowheath Park', '2024-05-19 00:00:00', '00:00:00', '23:59:00', 'Birmingham', 'Went to watch Lekan play football', 'Outdoor Activities', '["event-1716852575313-43210.jpeg", "event-1716852575407-39303.jpeg", "event-1716852575623-28341.jpeg", "event-1716852575759-5993.jpeg"]', false, NULL, 17, NULL, '2024-05-28 06:29:36');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (372, 'Wightwick Manor and Gardens', '2024-05-25 00:00:00', '00:00:00', '23:59:00', 'Wolverhampton', 'Explored a beautiful Victorian home built in 1887. Then we toured the gardens and walked around the lake after getting ice cream at the cafe. ', 'Historic Houses & Castles', '["event-1716853083157-36396.jpeg", "event-1716853087948-14278.jpeg", "event-1716853091458-87514.jpeg", "event-1716853096030-61091.jpeg", "event-1716853099934-83775.jpeg"]', false, NULL, 17, NULL, '2024-05-28 06:38:23');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (373, 'Circus Vegas', '2024-05-24 00:00:00', '17:00:00', '19:00:00', 'NEC Birmingham', 'Visited the circus with nan', 'Live Shows', '["event-1716853241262-32420.jpeg", "event-1716853241347-43374.jpeg", "event-1716853241526-15235.jpeg", "event-1716853241750-6255.jpeg"]', false, NULL, 17, NULL, '2024-05-28 06:40:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (374, 'Resort World', '2024-05-24 00:00:00', '17:00:00', '20:00:00', 'NEC Birmigham', 'Lekan and Anu spent evening at Resort world and nandos', 'Food & Drinks', '["event-1716853554887-61220.jpeg", "event-1716853557596-35215.jpeg", "event-1716853560396-25041.jpeg", "event-1716853565256-61534.jpeg"]', false, NULL, 17, NULL, '2024-05-28 06:46:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (375, 'Cup Final', '2024-05-28 00:00:00', '14:30:00', '17:30:00', 'Boldermere', 'Watched Lekans team in cup final. Harriet joined us.', 'Outdoor Activities', '["event-1716853798378-53963.jpeg", "event-1716853798555-18323.jpeg"]', false, NULL, 17, NULL, '2024-05-28 06:49:58');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (377, 'Conkers', '2024-05-28 00:00:00', '13:30:00', '17:00:00', 'Swadlincote', 'Family day out at Conkers. Adventure centre. Playground, activity trail, 4d cinema, plenty of things for kids and parents to enjoy. ', 'Adventure Activities', '["event-1716854729801-72866.jpeg", "event-1717011885258-14841.jpeg", "event-1717011901386-20786.jpeg", "event-1717012004037-5485.jpeg", "event-1717012004645-96170.jpeg"]', false, NULL, 17, NULL, '2024-05-28 07:05:47');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (378, 'Joined WayzAway!', '2024-05-27 00:00:00', '15:24:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 119, NULL, '2024-05-28 16:54:01');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (385, 'Joined WayzAway!', '2024-05-29 00:00:00', '10:52:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 124, NULL, '2024-05-30 16:52:58');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (387, 'Joined WayzAway!', '2024-05-31 00:00:00', '13:54:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 125, NULL, '2024-06-01 10:54:15');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (388, 'Joined WayzAway!', '2024-05-31 00:00:00', '18:33:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 126, NULL, '2024-06-01 23:33:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (389, 'Joined WayzAway!', '2024-05-31 00:00:00', '18:47:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 127, NULL, '2024-06-01 23:47:44');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (390, 'Joined WayzAway!', '2024-06-01 00:00:00', '20:39:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 128, NULL, '2024-06-02 07:39:23');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (391, 'Joined WayzAway!', '2024-06-02 00:00:00', '07:54:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 129, NULL, '2024-06-02 19:54:16');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (400, 'Joined WayzAway!', '2024-06-05 00:00:00', '17:28:00', '05:40:00', 'Jkt', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '["event-1717972865010-46117.jpeg"]', false, false, 130, NULL, '2024-06-06 17:28:31');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (402, 'Kings Heath Park', '2024-06-06 00:00:00', '00:00:00', '23:59:00', 'Birmingham', 'Zoe and Isabel play date with Lexi in Kings Heath Park and playground.', 'Parks & Garden', '["event-1717678126657-29682.jpeg", "event-1717678127385-9428.jpeg", "event-1717678128311-11673.jpeg", "event-1717678128889-5124.jpeg"]', false, NULL, 17, NULL, '2024-06-06 19:48:49');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (403, 'Malt House', '2024-06-06 00:00:00', '00:00:00', '23:59:00', 'Birmingham', 'The family along with nan and grandma went for a meal at Malt House then walk through Birmingham Central and canal.', 'Food & Drinks', '["event-1717678771430-92631.jpeg", "event-1717678772360-82009.jpeg", "event-1717678791417-86306.jpeg", "event-1717678804426-51486.jpeg", "event-1717678821416-41878.jpeg"]', false, NULL, 17, NULL, '2024-06-06 20:00:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (407, 'Sundance', '2024-06-07 00:00:00', '18:29:00', '21:45:00', 'Corvington', 'A wonderful amazing day out', 'Culture & History', '["event-1717769854949-39624.jpeg", "event-1717769868587-4107.jpeg", "event-1717769878755-46695.jpeg", "event-1717769767384-7028.jpeg", "event-1717769779733-90258.jpeg"]', false, NULL, 77, NULL, '2024-06-07 21:16:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (408, 'Cradley Regis', '2024-06-10 00:00:00', '00:00:00', '23:59:00', 'Heath Park', 'Walk on Sunday afternoon with mum', 'Nature Walks', '["event-1717975340549-28979.jpeg", "event-1717975340620-46068.jpeg", "event-1717975340626-40718.jpeg", "event-1717975340788-57027.jpeg", "event-1717975340867-25110.jpeg"]', false, NULL, 77, NULL, '2024-06-10 03:22:22');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (410, 'Rowheath Centenary', '2024-06-08 00:00:00', '14:30:00', '18:30:00', 'Bournville ', 'Celebrating 100 years of Rowheath. 

Live music performances, face painting, mini golf, mini care farm and the circus show, workshops, street food, craft stalls and fairground rides.

We also spent an hour playing football and sat on the grass.', 'Outdoor Activities', '["event-1717977021453-1169.jpeg", "event-1717977021517-8261.jpeg", "event-1717977021519-37809.jpeg", "event-1717977021520-43614.jpeg", "event-1717977021581-92689.jpeg"]', false, NULL, 17, NULL, '2024-06-10 03:50:22');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (411, 'Holders Lane', '2024-06-10 00:00:00', '18:00:00', '19:30:00', 'Birmingham', 'Family walk through Stirchley and Holders Lane with mum. Stopped at the stream to play.', 'Nature Walks', '["event-1717977277141-96000.jpeg", "event-1717977277150-53508.jpeg", "event-1717977277154-75190.jpeg", "event-1717977277159-63522.jpeg", "event-1717977277166-75758.jpeg"]', false, NULL, 17, NULL, '2024-06-10 03:54:37');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (412, 'Test', '2024-06-11 00:00:00', '00:00:00', '23:59:00', 'Dh', 'Dh', 'Arts & Craft', '[]', false, NULL, 77, NULL, '2024-06-11 05:54:25');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (413, 'Dydy', '2024-06-06 00:00:00', '00:00:00', '23:59:00', 'Dyry', 'Eyr', 'Christmas', '[]', false, NULL, 77, NULL, '2024-06-11 05:55:21');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (414, 'Ok', '2024-06-12 00:00:00', '00:00:00', '23:59:00', 'Ok', 'Ok', 'Arts & Craft', '[]', false, NULL, 77, NULL, '2024-06-11 06:08:53');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (415, 'Testeryy', '2021-01-20 00:00:00', '00:00:00', '23:59:00', 'Gg', 'Gg', 'Arts & Craft', '[]', false, NULL, 77, NULL, '2024-06-11 14:36:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (416, 'Comp', '2024-06-01 00:00:00', '00:00:00', '23:59:00', 'Hfb', 'Wasn''t for a walk and a dip in the lake. Then sat on the picnic mat in sunshine. Played football with Zoe, used the playground and had an ice cream or two

Rhebdn', 'Culture & History', '[]', false, NULL, 77, NULL, '2024-06-11 14:42:05');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (427, 'Joined WayzAway!', '2024-06-12 00:00:00', '12:47:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 165, NULL, '2024-06-13 13:47:52');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (431, 'Joined WayzAway!', '2024-06-13 00:00:00', '10:51:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 169, NULL, '2024-06-14 07:51:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (433, 'To Hayley''s', '2024-06-01 00:00:00', '00:00:00', '23:59:00', 'Herefordshire', 'Steph travelled with Lindsay to spend the day with Hayley', 'Day Trips', '["event-1718564743727-55631.jpeg", "event-1718564743750-3580.jpeg", "event-1718564743752-24961.jpeg", "event-1718564743754-49226.jpeg", "event-1718564743756-65814.jpeg"]', false, NULL, 17, NULL, '2024-06-16 18:05:44');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (434, 'Summer Fair - St Lawrence School', '2024-06-15 00:00:00', '11:30:00', '15:00:00', 'Birmingham', 'PTA school fair. Lekan ran the football stall. Zoe and Steph went around partaking in various games and activities.', 'Outdoor Activities', '["event-1718565316306-58746.jpeg", "event-1718565316309-10171.jpeg", "event-1718565316311-90992.jpeg", "event-1718565316314-94034.jpeg", "event-1718565316318-70160.jpeg"]', false, NULL, 17, NULL, '2024-06-16 18:15:16');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (435, 'Hickory Dickory', '2024-06-14 00:00:00', '15:30:00', '17:00:00', 'Birmingham', 'Zoe and Isabel at the Indoor play centre', 'Play Centres', '["event-1718565769517-65469.jpeg", "event-1718565769518-1638.jpeg", "event-1718565769520-14979.jpeg"]', false, NULL, 17, NULL, '2024-06-16 18:22:49');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (436, '805 Nigerian Restaurant', '2024-06-16 00:00:00', '00:00:00', '23:59:00', 'London', 'Father''s day meal with the family. 805 Nigerian restaurant at Old Kent Road in London', 'Food & Drinks', '["event-1718566049778-80431.jpeg", "event-1718566049783-96437.jpeg", "event-1718566049802-78862.jpeg", "event-1718566049803-42184.jpeg", "event-1718566049804-75933.jpeg"]', false, NULL, 17, NULL, '2024-06-16 18:27:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (438, 'Chasewater Country Park', '2024-06-22 00:00:00', '15:30:00', '17:05:00', 'Brownhills', 'Beautiful park with a large lake. Went for a long walk followed by a quick dip. We then had a picnic, enjoyed an ice cream...or two, then played football with the kids.', 'Parks & Garden', '["event-1720053125194-1710.jpeg", "event-1720053125214-97702.jpeg", "event-1720053301930-60588.jpeg", "event-1720053301932-10736.jpeg", "event-1719091168556-64113.jpeg"]', false, NULL, 17, NULL, '2024-06-22 20:19:29');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (439, 'Tudor Grange Swimming & Brueton Park', '2024-06-23 00:00:00', '16:20:00', '18:15:00', 'Solihull', 'Open Swimming with Zoe and Isabel. Was Isabel first time swimming. Followed by a quick visit to Brueton Park', 'Indoor Activities', '["event-1719167281947-11585.jpeg", "event-1719167281950-58016.jpeg", "event-1719167281954-64921.jpeg", "event-1719167281956-58782.jpeg", "event-1719167281958-71064.jpeg"]', false, NULL, 17, NULL, '2024-06-23 17:28:02');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (440, 'Wahaca Mexican Restaurant', '2024-06-26 00:00:00', '18:00:00', '20:30:00', 'London', 'Mexican restaurant. Meal after work in central London.', 'Food & Drinks', '["event-1719358833152-41621.jpeg", "event-1719358833153-80753.jpeg"]', false, NULL, 17, NULL, '2024-06-25 22:35:43');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (441, 'Joined WayzAway!', '2024-06-27 00:00:00', '08:43:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 172, NULL, '2024-06-28 03:43:05');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (442, 'Joined WayzAway!', '2024-06-27 00:00:00', '13:53:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 173, NULL, '2024-06-28 10:53:15');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (451, 'Joined WayzAway!', '2024-07-02 00:00:00', '19:05:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 181, NULL, '2024-07-03 18:05:51');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (455, 'Joined WayzAway!', '2024-07-06 00:00:00', '11:52:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, true, 184, NULL, '2024-07-06 18:53:01');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (456, 'Fayoke 37th Birday BBQ', '2024-07-06 00:00:00', '15:00:00', '22:00:00', 'Bromley', 'Had a big family BBQ for fayoke 37th birthday', 'Family', '["event-1720312655602-59067.jpeg", "event-1720312655628-2060.jpeg", "event-1720312655630-249.jpeg", "event-1720312655631-41654.jpeg", "event-1720312655648-44093.jpeg"]', false, NULL, 17, NULL, '2024-07-07 00:37:37');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (462, 'Joined WayzAway!', '2024-07-11 00:00:00', '17:21:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 187, NULL, '2024-07-12 16:21:32');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (463, 'Joined WayzAway!', '2024-07-12 00:00:00', '03:03:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 188, NULL, '2024-07-13 02:03:49');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (466, 'Felson & Wetherspoons', '2024-07-13 00:00:00', '20:00:00', '12:30:00', 'Birmingham', 'Lekan went on night out with his friends. Played pool at Felsons then food at Whetherspoons (Solomon Cutler)', 'Food & Drinks', '["event-1721066614619-57164.jpeg", "event-1721066614630-58741.jpeg", "event-1721066496846-37977.jpeg", "event-1721066496877-74903.jpeg", "event-1721066496893-14693.jpeg"]', false, NULL, 17, NULL, '2024-07-15 18:01:40');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (467, 'Amritsari Tarka', '2024-07-14 00:00:00', '13:00:00', '16:30:00', 'Soho Road, Birmingham', 'Steph went to an Indian restaurant with Ranjit, Bal and Harriet', 'Food & Drinks', '["event-1721066769674-31946.jpeg", "event-1721066769677-10210.jpeg"]', false, NULL, 17, NULL, '2024-07-15 18:06:10');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (468, 'Hickory Dickory', '2024-07-15 00:00:00', '14:30:00', '16:00:00', 'Kings Heath', 'Children soft play area. Zoe and Isabel also had dinner.', 'Play Centres', '["event-1721070048387-74257.jpeg", "event-1721070048398-1251.jpeg", "event-1721070048417-56192.jpeg", "event-1721070048428-47255.jpeg", "event-1721070048442-24317.jpeg"]', false, NULL, 17, NULL, '2024-07-15 19:00:49');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (469, 'Mum leaves', '2024-07-11 00:00:00', '00:00:00', '23:59:00', 'Birmingham', 'Mum leaves to go back to Canada after spending at month with us', 'Family', '["event-1721077120700-70249.jpeg", "event-1721077120707-29309.jpeg", "event-1721077120710-38585.jpeg", "event-1721077120711-57150.jpeg"]', false, NULL, 17, NULL, '2024-07-15 20:58:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (470, 'Joined WayzAway!', '2024-07-16 00:00:00', '21:52:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 191, NULL, '2024-07-17 19:52:59');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (471, 'To Isle of Man', '2024-07-23 00:00:00', '00:00:00', '23:59:00', 'Liverpool - Douglas', 'We leave the UK to spend 4 weeks in Isle of Man. Drive to Liverpool port and took the boat to Douglas. ', 'Holidays', '["event-1722031114059-71723.jpeg", "event-1722031061104-66194.jpeg", "event-1722031114061-22495.jpeg", "event-1722031061109-27938.jpeg"]', false, NULL, 17, NULL, '2024-07-26 21:57:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (472, 'Joined WayzAway!', '2024-07-28 00:00:00', '12:57:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 192, NULL, '2024-07-29 11:57:22');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (473, 'Port Erin Beach', '2024-07-28 00:00:00', '13:30:00', '17:30:00', 'Isle of Man', 'Went down to Port Erin sandy beach on the south of the Island. Went into the sea, played on the sand and stopped for some ice cream.', 'Water Activities', '["event-1722284616522-94853.jpeg", "event-1722284616529-21680.jpeg", "event-1722284616531-7598.jpeg", "event-1722284616532-1098.jpeg", "event-1722284616534-43059.jpeg"]', false, NULL, 17, NULL, '2024-07-29 20:23:37');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (474, 'Douglas', '2024-08-01 00:00:00', '10:00:00', '14:30:00', 'Isle of Man', 'Steph and Zoe went to meet Beth, Pete, Thank and Toby at Douglas', 'Day Trips', '["event-1722773539155-17792.jpeg", "event-1722773539162-63131.jpeg", "event-1722773539164-54038.jpeg", "event-1722773539165-97905.jpeg"]', false, NULL, 17, NULL, '2024-08-04 12:12:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (475, 'Snaefell', '2024-08-01 00:00:00', '14:30:00', '17:00:00', 'Isle of Man', 'Steph and Zoe along with Beth, Pete, Ethan and Toby took a cabe car to the highest point of Isle of Man. ', 'Day Trips', '["event-1722773697219-49792.jpeg", "event-1722773697227-33327.jpeg", "event-1722773697230-68918.jpeg", "event-1722773697232-41111.jpeg", "event-1722773697234-7619.jpeg"]', false, NULL, 17, NULL, '2024-08-04 12:14:58');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (476, 'Corrin''s Tower', '2024-08-01 00:00:00', '20:30:00', '22:45:00', 'Peel', 'Lekan, Steph and Zoe walked up peel Hill to Corrine Folly. A monument built by Thomas Corrin in honour of his wife and kids. Zoe enjoyed doing cartwheels and playing eye spy on the walk.', 'Nature Walks', '["event-1722774294472-36754.jpeg", "event-1722774294477-63785.jpeg", "event-1722774294488-53608.jpeg", "event-1722774294506-48957.jpeg", "event-1722774294507-61352.jpeg"]', false, NULL, 17, NULL, '2024-08-04 12:24:55');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (477, 'Niarbyl', '2024-08-03 00:00:00', '12:00:00', '12:30:00', 'Dalby', 'Niarbyl is a secluded beauty spot just south of Dalby Village on the Island''s west coast.

We stopped at the beach for a short while to enjoy the scenery', 'Outdoor Activities', '["event-1722774585470-85056.jpeg", "event-1722774585471-48828.jpeg", "event-1722774585472-28819.jpeg"]', false, NULL, 17, NULL, '2024-08-04 12:29:46');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (478, 'The Sound', '2024-08-03 00:00:00', '14:00:00', '16:00:00', 'Port Erin', 'The Sound, at the very southern tip of the Isle of Man, is a beautiful place to appreciate the Island''s coastal beauty

We stopped over and were amazed to see the sea lions on the rocks. It was a nice day so we also played a game of catch and had a short walk. Before stopping at the cafe to have a few drinks and ice cream.', 'Day Trips', '["event-1722775131981-68728.jpeg", "event-1722775131988-63988.jpeg", "event-1722775132004-64399.jpeg", "event-1722775132004-72950.jpeg", "event-1722775132006-34423.jpeg"]', false, NULL, 17, NULL, '2024-08-04 12:38:52');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (479, 'The Sound Cafe', '2024-08-03 00:00:00', '14:00:00', '16:00:00', 'Port Erin', 'Cafe at the Sound. Had ice cream and Isabel had chips and sausage.', 'Food & Drinks', '["event-1722775337034-24234.jpeg", "event-1722775337060-78750.jpeg", "event-1722775337062-76518.jpeg"]', false, NULL, 17, NULL, '2024-08-04 12:42:17');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (480, 'Home of Rest for Old Horses', '2024-08-03 00:00:00', '16:00:00', '17:00:00', 'Douglas', 'Set in over 90 acres of land, the Home currently cares for over sixty horses and ponies and eleven donkeys.

Stopped to feed the horses and donkeys.', 'Animal and Wildlife', '["event-1722795715203-93551.jpeg", "event-1722795715209-67413.jpeg", "event-1722795715227-6309.jpeg", "event-1722795715270-4459.jpeg", "event-1722795715272-61776.jpeg"]', false, NULL, 17, NULL, '2024-08-04 18:21:56');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (481, 'Peel Carnival', '2024-08-04 00:00:00', '13:30:00', '16:00:00', 'Peel', 'The annual Peel carnival. Music, food, parade and we saw dolphins in Peel Bay', 'Culture & History', '["event-1722795910579-17733.jpeg", "event-1722795910586-84099.jpeg", "event-1722795910592-78186.jpeg", "event-1722795910592-73917.jpeg", "event-1722795910593-18801.jpeg"]', false, NULL, 17, NULL, '2024-08-04 18:25:11');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (482, 'Joined WayzAway!', '2024-08-05 00:00:00', '23:26:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 193, NULL, '2024-08-06 22:26:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (483, 'Tynwald National Park & Arboretum', '2024-08-06 00:00:00', '14:00:00', '17:00:00', 'St John''s, Isle of Man', 'Perfect place to enjoy a picnic on a hot summer’s day or to get some fresh air and feed the ducks!

Nan took the girls for a walk and to see Grandpa Tony bench.', 'Parks & Garden', '["event-1723468631897-59578.jpeg", "event-1723468631902-41877.jpeg", "event-1723468631907-77227.jpeg", "event-1723468631909-31157.jpeg"]', false, NULL, 17, NULL, '2024-08-12 13:17:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (484, 'Mooragh Lake Park', '2024-08-10 00:00:00', '13:00:00', '17:30:00', 'Ramsey', 'Has a playground, picnic area, mini golf, splash pad and surrounds a lovely lake.

Took cooper along and the kids enjoyed running around and catching fish with their net', 'Parks & Garden', '["event-1723470987700-18458.jpeg", "event-1723470030751-33941.jpeg", "event-1723470030752-66040.jpeg", "event-1723470030755-55021.jpeg", "event-1723470030776-20436.jpeg"]', false, NULL, 17, NULL, '2024-08-12 13:40:33');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (485, 'The Boathouse Eatery', '2024-08-10 00:00:00', '15:00:00', '15:30:00', 'Mooragh Lake Park, Ramsey', 'Cafe in Mooragh park. Serving coffee, cake, brunch...

We all had ice cream including Isabel.', 'Food & Drinks', '["event-1723470370649-62301.jpeg", "event-1723470370656-16012.jpeg", "event-1723470370658-82189.jpeg", "event-1723470370660-45224.jpeg"]', false, NULL, 17, NULL, '2024-08-12 13:46:11');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (486, 'Mooragh Park Lake', '2024-08-10 00:00:00', '15:30:00', '16:00:00', 'Ramsey', 'Hired a boat and took Simi and Cooper for a 30 mins ride around the lake.', 'Water Activities', '["event-1723470818789-36779.jpeg", "event-1723470818812-38302.jpeg", "event-1723470818820-26047.jpeg", "event-1723470818821-23834.jpeg", "event-1723470818823-92636.jpeg"]', false, NULL, 17, NULL, '2024-08-12 13:53:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (487, 'Groudle Glenn Railway', '2024-08-11 00:00:00', '14:30:00', '18:00:00', 'Douglas-Onchan, Isle of Man', ' The Groudle Glen Railway is a 2 ft narrow gauge railway near Onchan in the Isle of Man, on the boundary of Onchan and Lonan, which is owned and operated by a small group of enthusiastic volunteers.

We walked through the woods and stopped at the gift shop. The rail journey took about 10 minutes.', 'Adventure Activities', '["event-1723471398334-14242.jpeg", "event-1723471398341-43002.jpeg", "event-1723471398343-45457.jpeg", "event-1723471531602-13506.jpeg", "event-1723471398346-7059.jpeg"]', false, NULL, 17, NULL, '2024-08-12 14:03:19');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (488, 'Sea Lion Rocks', '2024-08-11 00:00:00', '15:30:00', '16:30:00', 'Baldrine, Isle of Man', 'We took Groudle glen railway to the small tea room cafe and listen to band music, enjoyed the scenery and enjoyed the weather.', 'Outdoor Activities', '["event-1723471802594-49091.jpeg", "event-1723471802601-79377.jpeg", "event-1723471802604-68651.jpeg", "event-1723471802605-557.jpeg"]', false, NULL, 17, NULL, '2024-08-12 14:10:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (489, 'Groudle', '2024-08-11 00:00:00', '16:30:00', '18:00:00', 'Douglas-Onchan', 'After leaving the railway we tool a nice walk through Groudle and enjoyed the amazing nature scenery...before getting lost and eventually making our way back to the car', 'Nature Walks', '["event-1723472352625-38798.jpeg", "event-1723472100486-65740.jpeg", "event-1723472352632-81129.jpeg", "event-1723472100492-97198.jpeg", "event-1723472100494-73426.jpeg"]', false, NULL, 17, NULL, '2024-08-12 14:15:01');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (490, 'Aunt Pat and Uncle Kev', '2024-08-11 00:00:00', '18:00:00', '20:30:00', 'Glen Vine', 'Stopped at Aunt Pat and Uncle Kev to say hello.', 'Family', '["event-1723472297718-96223.jpeg", "event-1723472297721-8206.jpeg", "event-1723472297724-50304.jpeg"]', false, NULL, 17, NULL, '2024-08-12 14:18:18');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (491, 'Glen Wyllin', '2024-08-12 00:00:00', '18:00:00', '19:30:00', 'Isle of Man', 'A glen in the Isle of Man. It is one of the officially-listed Manx National Glens. The Glen Wyllin Pleasure Grounds are owned by the Isle of Man Railway whose line crossed the valley by means of a viaduct.

The site is popular amongst campers but we stopped for a couple of hours at the beach located here. It was a warm evening with cool breeze. We also caught a glimpse of a couple of dolphins that swam close to the shore.', 'Outdoor Activities', '["event-1723493582942-95499.jpeg", "event-1723493048588-45010.jpeg", "event-1723493048591-4576.jpeg", "event-1723493048601-30566.jpeg", "event-1723493048602-11526.jpeg"]', false, NULL, 17, NULL, '2024-08-12 20:04:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (492, 'Peel Headlands', '2024-08-14 00:00:00', '13:00:00', '16:00:00', 'Peel', 'Nan took the girls out to Peel headlands and they also stopped at Peel beach to have an ice cream.', 'Outdoor Activities', '["event-1723665065066-38680.jpeg", "event-1723665065071-66743.jpeg", "event-1723665065074-84753.jpeg"]', false, NULL, 17, NULL, '2024-08-14 19:51:05');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (493, 'Joined WayzAway!', '2024-08-15 00:00:00', '16:20:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 194, NULL, '2024-08-15 21:20:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (494, 'Joined WayzAway!', '2024-08-18 00:00:00', '09:01:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 195, NULL, '2024-08-19 08:01:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (495, 'Joined WayzAway!', '2024-08-20 00:00:00', '10:36:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 196, NULL, '2024-08-20 14:36:25');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (496, 'Joined WayzAway!', '2024-08-23 00:00:00', '16:34:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 197, NULL, '2024-08-24 14:34:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (497, 'Joined WayzAway!', '2024-08-26 00:00:00', '22:44:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 199, NULL, '2024-08-27 21:44:40');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (498, 'Milntown Estate and Gardens', '2024-08-17 00:00:00', '13:00:00', '16:00:00', 'Ramsay', 'Explored the gardens of the historic house.

Set in 15 acres of scenic gardens, Milntown estate is one of the Isle of Man''s most historic country homes. The estate was founded in the early 16th Century ', 'Historic Houses & Castles', '["event-1724823987796-22396.jpeg", "event-1724823987803-36291.jpeg", "event-1724823987807-91064.jpeg", "event-1724823987809-51119.jpeg", "event-1724823987810-70426.jpeg"]', false, NULL, 17, NULL, '2024-08-28 05:46:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (499, 'The Boathouse Eatery', '2024-08-17 00:00:00', '15:00:00', '16:00:00', 'Ramsay', 'Stopped for ice cream and cake', 'Food & Drinks', '["event-1724824220038-72366.jpeg", "event-1724824220040-77680.jpeg", "event-1724824220060-1908.jpeg"]', false, NULL, 17, NULL, '2024-08-28 05:50:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (500, 'Sulby Reservoir', '2024-08-17 00:00:00', '17:00:00', '18:30:00', 'Sulby', 'The Island''s largest and deepest reservoir.

We went for a nice walk with Simi on her bike.', 'Nature Walks', '["event-1724824598004-93053.jpeg", "event-1724824598009-99438.jpeg", "event-1724824598021-63951.jpeg", "event-1724824598065-48972.jpeg", "event-1724824598110-77889.jpeg"]', false, NULL, 17, NULL, '2024-08-28 05:56:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (501, 'Leaving Isle of Man', '2024-08-19 00:00:00', '13:00:00', '23:59:00', 'Peel-Douglas', 'The day we left the Island. Had a cabin on the new boat', 'Family', '["event-1724824762696-82684.jpeg", "event-1724824762697-78650.jpeg", "event-1724824762699-75350.jpeg", "event-1724825245071-31682.jpeg"]', false, NULL, 17, NULL, '2024-08-28 05:59:23');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (502, 'Rowheath', '2024-08-25 00:00:00', '10:00:00', '14:00:00', 'Bournville', 'Dad went yo play football. The family set on the grass and watched. ', 'Family', '["event-1724824911705-97169.jpeg", "event-1724824911706-97023.jpeg", "event-1724824911707-39911.jpeg", "event-1724824911708-21985.jpeg", "event-1724824911709-5550.jpeg"]', false, NULL, 17, NULL, '2024-08-28 06:01:52');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (503, 'Abbey Park', '2024-08-26 00:00:00', '15:00:00', '18:00:00', 'Evesham', 'A day out in the beautiful park. Ice cream, splash pad and finished in the sand pit. Maya came with us.', 'Parks & Garden', '["event-1724825074778-80178.jpeg", "event-1724825074789-34250.jpeg", "event-1724825074791-57931.jpeg", "event-1724825074793-1061.jpeg", "event-1724825074794-79153.jpeg"]', false, NULL, 17, NULL, '2024-08-28 06:04:35');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (504, 'Joined WayzAway!', '2024-08-27 00:00:00', '18:50:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 200, NULL, '2024-08-28 08:50:44');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (505, 'Arley Arboretum', '2024-08-29 00:00:00', '12:30:00', '16:00:00', 'Bewdley', 'Arley Arboretum is home to over 300 species of trees, it features Britain''s longest Laburnum arch, and is popular with nature lovers, families and walkers.

We enjoyed walking through the gardens and woods.', 'Nature Walks', '["event-1724978517323-80456.jpeg", "event-1724978517328-60993.jpeg", "event-1724978517332-49550.jpeg", "event-1724978517334-53588.jpeg", "event-1724978517335-46754.jpeg"]', false, NULL, 17, NULL, '2024-08-30 00:41:58');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (506, 'Cotswold Country Park & Beach', '2024-08-31 00:00:00', '12:30:00', '16:00:00', 'Cirencester', 'Water Park in the Cotsworld. A beautiful lake with a man made dandy beach. Plenty of water activities, food and sunshine.

We enjoyed splashing in the lake and building sand castles.', 'Water Activities', '["event-1725150458291-30610.jpeg", "event-1725150458298-92651.jpeg", "event-1725150458301-28434.jpeg", "event-1725150458302-41459.jpeg", "event-1725150479446-98895.jpeg"]', false, NULL, 17, NULL, '2024-09-01 00:27:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (507, 'Joined WayzAway!', '2024-08-31 00:00:00', '07:27:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 201, NULL, '2024-09-01 03:27:36');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (508, 'Joined WayzAway!', '2024-09-04 00:00:00', '12:06:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 202, NULL, '2024-09-05 10:06:34');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (510, 'Joined WayzAway!', '2024-09-10 00:00:00', '08:02:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 204, NULL, '2024-09-10 22:02:54');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (511, 'Zoe Tennis Tournament', '2024-09-07 00:00:00', '10:00:00', '11:00:00', 'Beechroft Tennis Club', 'Zoe took part in children tennis tournament and enjoyed her self.', 'Outdoor Activities', '["event-1726015321270-20239.jpeg", "event-1726015321281-41791.jpeg"]', false, NULL, 17, NULL, '2024-09-11 00:42:02');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (512, 'Hollywood Bowls', '2024-09-07 00:00:00', '13:00:00', '16:00:00', 'Merry Hill', 'Took the girls to the arcade where we enjoyed playing some fun games. ', 'Indoor Activities', '["event-1726015461480-65273.jpeg", "event-1726015461481-59939.jpeg"]', false, NULL, 17, NULL, '2024-09-11 00:44:22');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (513, 'Charlecote Park', '2024-09-08 00:00:00', '11:00:00', '02:00:00', 'Stratford-Upon-Avon', 'A large park with an old grand house surrounded by a deers and nature.

Steph and the girls drove down with Harriet for the morning.', 'Historic Houses & Castles', '["event-1726015694832-54142.jpeg", "event-1726015694838-1511.jpeg", "event-1726015694840-63092.jpeg", "event-1726015694841-67303.jpeg", "event-1726015716653-89292.jpeg"]', false, NULL, 17, NULL, '2024-09-11 00:48:15');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (514, 'Joined WayzAway!', '2024-09-23 00:00:00', '14:50:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 205, NULL, '2024-09-24 12:50:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (515, 'Joined WayzAway!', '2024-09-27 00:00:00', '23:29:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 206, NULL, '2024-09-28 21:29:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (516, 'Joined WayzAway!', '2024-10-12 00:00:00', '12:54:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 207, NULL, '2024-10-12 16:54:57');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (518, 'Joined WayzAway!', '2024-10-13 00:00:00', '23:58:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 209, NULL, '2024-10-14 21:58:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (519, 'Joined WayzAway!', '2024-10-14 00:00:00', '12:15:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 210, NULL, '2024-10-15 01:15:34');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (520, 'Joined WayzAway!', '2024-10-20 00:00:00', '19:38:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 211, NULL, '2024-10-20 11:42:22');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (521, 'Daniel 7th Birthday Party', '2024-09-21 00:00:00', '00:00:00', '23:59:00', 'Rock up - Birmingham', 'Zoe attended her classmates 7th Birthday party in Rock up.

They enjoyed wall climbing followed by a birthday meal.', 'Birthday Party', '["event-1729517318582-52658.jpeg", "event-1729517318590-98231.jpeg", "event-1729517318593-53898.jpeg", "event-1729517318595-83192.jpeg", "event-1729517318598-75246.jpeg"]', false, NULL, 17, NULL, '2024-10-21 13:28:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (522, 'Habberley Trail', '2024-10-05 00:00:00', '13:00:00', '18:00:00', 'Kidderminster', 'We took Zoe and Lexi to Habberley trail. ', 'Outdoor Activities', '["event-1729517943128-19452.jpeg", "event-1729517904973-78606.jpeg", "event-1729517904976-76216.jpeg", "event-1729517904981-31324.jpeg", "event-1729517904983-97097.jpeg"]', false, NULL, 17, NULL, '2024-10-21 13:38:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (523, 'Tyker''s 7th Birthday', '2024-10-12 00:00:00', '00:00:00', '23:59:00', 'Treetop gold - Pizza Express in Bullring', 'Zoe went to Tyler''s 7th Birthday party. She met Tyker along with her friends from Nursery. 

Started with a game at treetop indoor golf followed by pizza express.', 'Birthday Party', '["event-1729518463208-76139.jpeg", "event-1729518463215-79107.jpeg"]', false, NULL, 17, NULL, '2024-10-21 13:47:43');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (526, 'Real Midlands 5 - 1 Camden', '2024-09-01 00:00:00', '10:30:00', '13:30:00', 'Elmdon Heath', 'First game of the 2024 season ended with a disappointing loss.

Team was largely meeting for the first time with so many not available for pre-season.

Real Midlands started off shaky but scored first. Camden equalised after a through ball to Tom from Will. However Real Midlands ended up dominating the whole game scoring 4 more goals to get a comfortable victory.

We shot ourselves in the foot, with three of the goals against us coming from keeper mistakes and one other from failure to clear the ball. Karim had a couple chances which he would have buried on another day, he''s rustiness is understood given it was his first league game in a year and had only played 1 pre season game prior to this.
Other than that we didn''t really threaten Real Midlands and the game was comfortable for them.

Camden Squad
Emad
Khalid
David
Joe
Jordan
Will 
Laye
Badri
Tom
Maz
Karim

Sub
Deano
Luke

Goals: Tom assisted by Will', 'Sport & Leisure', '["event-1729540978016-21177.jpeg", "event-1729540978052-23722.jpeg"]', false, NULL, 212, NULL, '2024-10-21 20:03:00');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (527, 'Blaze 9 - 2 Camden', '2024-09-08 00:00:00', '10:30:00', '13:30:00', 'George Salter Academy', 'Festival Cup

We started strong by scoring  early to go 1 nil up from a converted penalty by Karim. But a defensive mistake from Khalid led to an equaliser. Karim scored another goal from a Maz cross to make it 2-1. Karim took the ball down well from the cross and put it into the bottom corner with a clever finish.

From then on Camden collapse. Mistake after mistake from Camden resulted on easy goals against us.

It didn''t help that we started arguing amongst each other and by second half the game plan went out the window. Birmingham Blaze goal keeper was sent off for handballing outside the area. A mistake from the ref as this isn''t a red card offence. However, even with 10 men Blaze went on to score 5 more goals against us.

Goals:
Karim, won a penalty assisted by Tom
Karim assisted by Maz

Team:
Deano
Khalid
David
Jordan
Doyin
Will
Sam
Badri
Maz
Karim
Tom

Sub:
Joe
Jerome
', 'Sport & Leisure', '["event-1729543210702-72431.jpeg", "event-1729543210721-17445.jpeg", "event-1729543210757-92585.jpeg"]', false, NULL, 212, NULL, '2024-10-21 20:40:13');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (528, 'Project XI 5 - 0 Camden', '2024-09-15 00:00:00', '13:00:00', '15:30:00', 'Heartlands Academy', 'A better performance against the league leaders. But again mistakes cost us at the back. We made 4 individual mistakes that led to 4 goals for them.

With that being said, our attack was non existence. We only created 1 clear chance.

Team:
Laye
Joe
Manny
Luke
Jordan
David
Sam
Will
Badri
Karim
Tom

Sub:
Adrian ', 'Sport & Leisure', '["event-1729548896522-45704.jpeg"]', false, NULL, 212, NULL, '2024-10-21 22:14:57');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (529, 'Bizspace 1 - 1 Camden', '2024-09-22 00:00:00', '10:30:00', '13:30:00', 'Calthorpe Park', 'A much better performance. We switched to 3 at the back to deal with Bizspace long balls. The formation worked well.

The game was tight and remained goaless at half time. Will and Sam worked hard as a two in midfield and as the game went on Camden started to take control. We scored first early in the second half after a great ball from Tom to Hansu and he cleverly laid it off to Badri who lobbed the keeper with a shot from outside the area.

Bizspace came back into the game last 15 mins. And again we conceded from a set piece after we failed to follow the second ball.

Goal: Badri assisted by Hansu

Team:
Adrian
Joe
David
Manny
Deano
Doyin
Hansu
Will
Sam
Tom
Badri

Sub:
Jordan', 'Sport & Leisure', '["event-1729549633914-74676.jpeg", "event-1729549633921-47608.jpeg", "event-1729549633924-91385.jpeg"]', false, NULL, 212, NULL, '2024-10-21 22:27:14');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (530, 'Camden 4 - 3 Villa Tavern', '2024-09-29 00:00:00', '10:30:00', '13:30:00', 'Rowheath', 'Our first win of the season came in dramatic fashion.

Camden scored first but Villa Tavern got a goal back. With both sides getting plenty of chances both teams were 3 all with only a few minutes left.

However, after a great cross from Adrian, Badri slammed home the winner with a great header in the last 2 minutes. We were able to hold out for a great win.

Goals:
Karim x 2
Hansu
Badri

Team:
Adrian
Joe
David
Deano
Doyin
Manny
Will
Badri
Tom
Karim
Hansu

Sub:
Adrian', 'Sport & Leisure', '["event-1729550588243-69885.jpeg", "event-1729550588267-86891.jpeg"]', false, NULL, 212, NULL, '2024-10-21 22:43:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (531, 'Wanderers 3 - 3 Camden', '2024-10-06 00:00:00', '10:30:00', '13:30:00', 'Twickenham', 'A decent result against on of the better teams in the league.

We went 2 nil down in the first 15 minutes.

We started with 5 at the back but after a change of formation by putting an extra man in midfield things improved. We also realised that playing more direct to exploit their weak defence.

Karim managed to get us a goal back, then we unfortunately went 3 - 1 down. However after another change of formation in the second half going 442. We dominated the game and put the game back to 3 all after a great finish from Tom.

Wanderers did get a last minute penalty after their player tripped over his own foot. But with the last kick of the game their taker skied the penalty.

Goals:
Karim x 2
Tom

Team:
Adrian
Tom
David
Manny
Deano
Doyin
Badri
Will
Adrian
Karim
Jerome

Subs:
Joe
Sam
Wes', 'Sport & Leisure', '["event-1729551956576-10420.jpeg"]', false, NULL, 212, NULL, '2024-10-21 23:05:57');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (532, 'Joined WayzAway!', '2024-10-21 00:00:00', '09:25:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 213, NULL, '2024-10-22 05:25:13');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (533, 'Camden 4 (8) - (9) 4 North Birmingham', '2024-10-13 00:00:00', '10:30:00', '13:30:00', 'Rowheath', 'Festival Cup

A game that Camden really should''ve have won. We threw away a 2 goal lead on two occasions.

Unfortunately two keeping mistakes from Adrian let them back in the game.  However all their goals came from set pieces, a couple of which was poorly defended by Camden. Likewise Manny mistake as linesman allowed a clearly offside goal to stand.

The game went to pens. Most of us scored and after 11 penalty taken it came down to the keepers to decide the game. 

Goals:
Karim x 2
Jerome
Doyin

Team:
Adrian
Joe
David
Deano
Doyin
Manny
Will
Badri
Jerome
Karim
Adrian

Sub:
Alex
Wes', 'Sport & Leisure', '["event-1729642670183-33477.jpeg", "event-1729642670214-97997.jpeg", "event-1729642670230-50831.jpeg", "event-1729642670249-20948.jpeg", "event-1729642670308-55704.jpeg"]', false, NULL, 212, NULL, '2024-10-23 00:17:54');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (534, 'Beaufort Arms 2 - 4 Camden', '2024-10-20 00:00:00', '10:30:00', '13:30:00', 'Cooksey Lane', 'Festival and Sutton Inter cup

We started poorly with a goal conceded in first 5 minutes  when keeper misjudged a long ball and it bounced over him into the goal.

But we recovered well and after a shaky start Karim scored from a Badri through ball.

We got lucky with a Jerome goal that was offside to make it 2 - 1.

Then another piece of luck when referee gave a corner to Camden that was a goal kick. Sam scored from the preceding corner to make it 3 - 1.

Camden continued to dominate until Jerome made it 4 - 1 in second half. Beaufort made it interesting by getting one back. But Camden had several chances to score even more and remained in control for the remainder of the game.

Sam in midfield put in a man of the match performance with his energy and closing down.

Goals:
Karim assisted by Badri
Jerome assisted by Alex
Sam assisted by Manny
Jerome assisted by Alex

Team:
Adrian
Joe
Deano
David
Doyin
Alex
Manny
Sam
Jerome
Badri
Karim

Sub:
Adrian
Laye', 'Sport & Leisure', '["event-1729643240550-66305.jpeg"]', false, NULL, 212, NULL, '2024-10-23 00:27:21');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (535, 'Team Stats 2024/25 Season', '2024-08-31 00:00:00', '00:00:00', '23:59:00', 'Festival League', 'Appearance:

Adrian - 7
Joe - 8 (3)
Luke - 1 (1)
David - 12
Dean - 7 (2)
Doyin - 10
Jordan - 5 (2)
Curtis - 0
Alex - 2 (1)
Manny - 8 (1)
Wes - 0 (2)
Will - 10 (1)
Sam M - 8 (1)
Jared - 0
Laye - 2 (1)
Badri - 11 (1)
Sam O - 1 (1)
Adrian - 5 (3)
Tom - 10
Karim - 11
Jerome - 4(1)
Hansu - 6 (3)
Khalid - 2

Goals:

Karim - 15
Tom - 8
Sam O - 4
Jerome - 3
Badri - 2
Will - 2
Sam M - 2
Hansu - 1
Doyin - 1
Adrian - 1

Assist:

Karim - 7
Tom - 5
Adrian - 4
Badri - 3
Jerome - 2
Alex - 2
Will - 2
Manny - 2
Doyin - 2
Hansu - 2
Sam O - 1
Maz - 1
Karim - 1
Wes - 1
Deano - 1
Joe - 1

Man of the Match:

Doyin - 6
Tom - 3
Sam O - 2
Adrian Varga - 1
Sam - 1
Karim - 1
David - 1', 'Sport & Leisure', '["event-1729700217386-42923.jpeg"]', true, NULL, 212, NULL, '2024-10-23 16:16:57');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (536, 'Joined WayzAway!', '2024-10-22 00:00:00', '18:45:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 214, NULL, '2024-10-23 17:45:44');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (537, 'Joined WayzAway!', '2024-10-22 00:00:00', '18:52:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 215, NULL, '2024-10-23 17:52:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (538, 'Joined WayzAway!', '2024-10-22 00:00:00', '19:30:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 216, NULL, '2024-10-23 18:30:53');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (539, 'Joined WayzAway!', '2024-10-22 00:00:00', '19:48:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 217, NULL, '2024-10-23 18:48:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (540, 'Joined WayzAway!', '2024-10-22 00:00:00', '20:08:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 218, NULL, '2024-10-23 19:08:21');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (541, 'Joined WayzAway!', '2024-10-22 00:00:00', '21:14:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 219, NULL, '2024-10-23 20:14:46');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (542, 'Joined WayzAway!', '2024-10-22 00:00:00', '21:59:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 220, NULL, '2024-10-23 20:59:08');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (544, 'Joined WayzAway!', '2024-10-23 00:00:00', '14:37:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 222, NULL, '2024-10-24 13:37:59');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (545, 'Joined WayzAway!', '2024-10-24 00:00:00', '10:23:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 223, NULL, '2024-10-25 09:23:27');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (546, 'Joined WayzAway!', '2024-10-24 00:00:00', '22:28:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 224, NULL, '2024-10-25 20:28:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (547, 'Joined WayzAway!', '2024-10-25 00:00:00', '12:19:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 225, NULL, '2024-10-26 10:19:07');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (590, 'First walk in Stourport! ', '2025-03-02 00:00:00', '16:00:00', '17:00:00', 'Stourport on Severn - River Stour', 'Took a stroll along the river to explore our new area. Saw a children''s play park in the distance. ', 'Nature Walks', '["event-1740946114108-51973.jpeg", "event-1740946114128-62326.jpeg", "event-1740946114154-47718.jpeg", "event-1740946114185-33915.jpeg"]', false, NULL, 17, NULL, '2025-03-02 20:08:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (548, 'Blaze 1 - 6 Camden', '2024-10-27 00:00:00', '10:15:00', '12:00:00', 'George Salter Academy', 'League Game

From start to finish Camden dominated the game. We wanted revenge after the heavy defeat in the cup and we proved how much better we are than them.

Karim and Tom took turns scoring and assisting between themselves. With Tom scoring probably the goal of the season so far with a first time strike from 20 yards across the keeper into the top corner.

Will finished the scoring off with a tap in after a free kick from Adrian was dropped by the keeper.

Team:

Adrian
Joe
David
Doyin
Jordan
Will
Sam
Badri
Karim
Tom
Adrian

Sub:
Hansu

Goals:
Karim assisted by Tom
Tom assisted by Karim x 3
Karim assisted by Adrian
Will assisted by Adrian

Motm:
Doyin very solid at the back and not afraid to get the ball and play out. And Tom for an excellent hatrick. Including a contender for goal of the season.', 'Sport & Leisure', '["event-1730047408832-75176.jpeg", "event-1730047408882-9760.jpeg"]', false, NULL, 212, NULL, '2024-10-27 16:43:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (549, 'Joined WayzAway!', '2024-10-26 00:00:00', '20:48:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 226, NULL, '2024-10-27 20:48:52');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (550, 'Joined WayzAway!', '2024-11-02 00:00:00', '21:43:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 227, NULL, '2024-11-03 20:43:02');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (552, 'Heath Ballerz vs Camden', '2024-11-03 00:00:00', '10:30:00', '12:30:00', 'Moor Lane', 'League Game

Camden started off well scoring early with a goal from Tom after a great cross from Karim.

But we got sloppy and let them back into it. We took the lead again before 2nd half after another cross from Karim to Tom.

Second half started off scrappy and once again we conceded from another free kick due to us having a deep line.

Things could''ve been worse but an amazing point blank save from Adrian kept the score level.

But luckily we got back into the game with a great lob finish from Sam and killed the game off when the leagues top scorer Karim finished it off with his customary goal.

Goals: 

Tom x 2 assisted by Karim x 2
Sam
Karim assisted by Joe

Motm: Adrian V and Tom

Team:
Adrian
Joe
David
Doyin
Hansu
Will
Sam
Alex
Adrian
Karim
Tom

Subs:
Manny
Badri
Deano', 'Sport & Leisure', '["event-1731028674929-74967.jpeg", "event-1731028675147-28640.jpeg"]', false, NULL, 212, NULL, '2024-11-08 01:17:59');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (553, 'Birmingham Art Gallery', '2024-10-26 00:00:00', '13:00:00', '17:00:00', 'Birmingham', 'Trip to Birmingham Art gallery with nan', 'Museums & Exhibitions', '["event-1731274946809-63112.jpeg"]', false, NULL, 17, NULL, '2024-11-10 21:42:28');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (554, 'Felsons', '2024-10-19 00:00:00', '19:00:00', '21:00:00', 'Birmingham', 'Pool with Ross and Lee', 'Friends', '["event-1731275078862-44529.jpeg"]', false, NULL, 17, NULL, '2024-11-10 21:44:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (555, 'Rowheath Fireworks', '2024-11-01 00:00:00', '18:00:00', '22:00:00', 'Rowheath', 'Went to watch fireworks at Rowheath. Zoe enjoyed some of the rides aswell.', 'Family Attractions', '["event-1731275367099-1788.jpeg", "event-1731275367141-51751.jpeg", "event-1731275367171-26127.jpeg"]', false, NULL, 17, NULL, '2024-11-10 21:49:29');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (556, 'Twycross Zoo', '2024-11-02 00:00:00', '12:00:00', '17:00:00', 'Atherstone', 'Lovely Zoo. Highlights were the tigers, giraffe and running rhino. Zoe and Isabel finished the day at the indoor play area.', 'Family Attractions', '["event-1731275659443-40978.jpeg", "event-1731275659445-50127.jpeg", "event-1731275659446-65077.jpeg", "event-1731275659449-37984.jpeg", "event-1731275659451-43983.jpeg"]', false, NULL, 17, NULL, '2024-11-10 21:54:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (557, 'Hayleys 40th', '2024-11-09 00:00:00', '00:00:00', '23:59:00', 'Hereford', 'Steph went to Hayleys with Nikita, Lindsay and Angela to celebrate Hayleys 40th. The girls enjoyed a weekend at her place and visited a restaurant.', 'Birthday Party', '["event-1731275954393-47693.jpeg", "event-1731275954399-66097.jpeg", "event-1731275954401-88666.jpeg", "event-1731275954402-75916.jpeg", "event-1731275954403-29384.jpeg"]', false, NULL, 17, NULL, '2024-11-10 21:59:15');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (558, 'Zoe Gymnastic Competition ', '2024-11-10 00:00:00', '08:00:00', '11:00:00', 'Solihull', 'Zoe first gymnastic competition. She was nervous but was brave and did her best.', 'Sport & Leisure', '["event-1731276104974-89504.jpeg", "event-1731276104981-57393.jpeg"]', false, NULL, 17, NULL, '2024-11-10 22:01:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (559, 'Joined WayzAway!', '2024-11-12 00:00:00', '10:05:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 228, NULL, '2024-11-13 04:35:10');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (560, 'Joined WayzAway!', '2024-11-18 00:00:00', '13:57:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 229, NULL, '2024-11-18 19:57:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (561, 'Camden vs North West Spartans', '2024-11-17 00:00:00', '10:30:00', '12:30:00', 'Rowheath', 'Sam Leach Memorial Cup

Probably one of the worst game of the season for Camden. Although we scored first we never really had control of the game.

First goal was an assist from Tom to Jerome. However after a mistake from one of our defenders and failure to deal with their runner they equalised. Spartans took the lead early in 1st half after Deano and David failed to communicate when going for an header which meant the ball dropped for their player to put in the bottom corner.

We managed to equalise from a Doyin header - corner from Tom.

The game went into penalties, although they missed their first after a good save from Adrian. We also missed our first. Unfortunately Deano the 5th taker missed his pen and Spartans go through to next round.

Camden never really had control of the game and in truth deserved to lose.

Goal

Jerome assisted by Tom
Doyin assisted by Tom

Motm - Hansu', 'Sport & Leisure', '["event-1732100182542-76972.jpeg"]', false, NULL, 212, NULL, '2024-11-20 10:56:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (562, 'Joined WayzAway!', '2024-11-20 00:00:00', '10:59:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 230, NULL, '2024-11-20 10:59:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (563, 'Yas and Stu (And Pete)', '2024-11-16 00:00:00', '12:00:00', '20:00:00', 'Chester', 'We went on a day trip to Chester to meet up with Yas and Stu. We went for a meal at Bella Italia before stopping at the Horror museum. We stopped at Pete''s mum shop to watch the Christmas lights come on.', 'Day Trips', '["event-1732101302356-52241.jpeg", "event-1732101302359-79996.jpeg", "event-1732101302367-9831.jpeg", "event-1732101302377-14581.jpeg", "event-1732101302380-39699.jpeg"]', false, NULL, 17, NULL, '2024-11-20 11:15:03');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (564, 'Flight club', '2024-11-17 00:00:00', '15:00:00', '21:00:00', 'Birmingham', 'Went out with Lee and Ross to play darts. Followed by a meal.', 'Friends', '["event-1732101837832-49794.jpeg", "event-1732101837839-32780.jpeg", "event-1732101837859-60180.jpeg"]', false, NULL, 17, NULL, '2024-11-20 11:23:59');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (565, 'Joined WayzAway!', '2024-11-23 00:00:00', '22:41:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 231, NULL, '2024-11-24 21:41:11');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (566, 'Joined WayzAway!', '2024-11-26 00:00:00', '16:48:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 232, NULL, '2024-11-27 15:48:55');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (567, 'Joined WayzAway!', '2024-11-28 00:00:00', '12:17:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', true, NULL, 233, NULL, '2024-11-29 11:17:43');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (591, 'Joined WayzAway!', '2025-03-03 00:00:00', '13:57:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 243, NULL, '2025-03-04 12:57:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (568, 'Villa Tavern vs Camden', '2024-12-01 00:00:00', '10:30:00', '12:30:00', 'Heartlands Academy', 'League Game

Started slow, went 2 nil down. We made a tactical change in midfield and things changed. Karim scored to get us to 2-1 before tom equalised and Karim scored to make it 3-2 by half time.

We came out and scored early with Karim completing his hatrick. Unfortunately Karim suffered a bad tackle and had to come off.

However, we continued with our momentum to score 2 more.

Camden suffered a temporary glitch which resulted in Villa Tavern pulling the score back to 5-3. But Camden carried on to finish the game strongly by scoring 3 more goals.

Goal scorers and Assist

Karim assisted by Tom
Karim assisted by Hansu
Karim assisted by Tom
Tom assisted by Doyin
Sam O assisted by Adrian
Adrian penalty won by Sam O
Will assisted by Badri
Sam O', 'Sport Events', '["event-1733751630993-40231.jpeg"]', false, false, 212, NULL, '2024-12-09 13:34:23');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (569, 'Gramps Funeral', '2024-11-22 00:00:00', '00:00:00', '23:59:00', 'Douglas', 'Steph travelled to Isle of Man for Gramps funeral on the 22nd.

Due to heavy winds she was delayed for a couple days', 'Family', '["event-1733753231183-4555.jpeg"]', false, NULL, 17, NULL, '2024-12-09 13:56:49');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (570, 'Bezerk World', '2024-11-22 00:00:00', '15:30:00', '19:00:00', 'Birmingham', 'Whilst Steph was away, Lekan took the girls to Bezerl world for play time.

Also had some food there.', 'Play Centres', '["event-1733753054150-82795.jpeg", "event-1733753054271-23182.jpeg", "event-1733753054555-27018.jpeg"]', false, NULL, 17, NULL, '2024-12-09 14:04:19');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (571, 'Resort World - Nandos', '2024-11-24 00:00:00', '14:30:00', '18:00:00', 'Birmingham International ', 'Steph travelled back and we met her at the airport before stopping at Resprt world. 

Also had a meal at Nandos', 'Food & Drinks', '["event-1733753657775-53948.jpeg", "event-1733753657805-5177.jpeg"]', false, NULL, 17, NULL, '2024-12-09 14:14:18');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (572, 'Afrikana  ', '2024-11-30 00:00:00', '00:00:00', '23:59:00', 'The O2 in London', 'Met together as a Faboya family for a meal at Afrikana.

Met leke girlfriend for the first time.', 'Family', '["event-1733753962723-76197.jpeg", "event-1733753962730-93051.jpeg", "event-1733753962734-22646.jpeg", "event-1733753962736-85298.jpeg", "event-1733753962737-79709.jpeg"]', false, NULL, 17, NULL, '2024-12-09 14:19:23');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (573, 'Joined WayzAway!', '2024-12-11 00:00:00', '11:40:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 234, NULL, '2024-12-12 05:40:43');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (574, 'Joined WayzAway!', '2024-12-24 00:00:00', '11:12:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 235, NULL, '2024-12-25 00:42:13');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (575, 'Camden vs Wanderers', '2024-12-15 00:00:00', '10:30:00', '12:30:00', 'Rowheath', 'Camden 2:0 Wanderers

League Game

A great win against closest rivals for 3rd spot.

After 3 seasons playing each other Camden registered their first win against Wanderers 

The game was tight but we were the slightly better team for the most part.

First goal came from a great cross from Karim to Sam. 

Second goal came from Sam.pressing on the defender to rob him off the ball before slotting into the bottom corner.

The defence was in great form and kept their attackers at bay for the most part.

Goal scorers: Sam 0 x 2

Motm: Sam O and Doyin', 'Sport Events', '["event-1735609091923-44646.jpeg"]', false, NULL, 212, NULL, '2024-12-31 01:38:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (576, 'Team Xmas social', '2024-12-21 00:00:00', '18:00:00', '20:30:00', 'Toca Social', 'Toca social in bullring.

Bar with football games, had food and drinks.', 'Indoor Activities', '["event-1735610171002-89537.jpeg", "event-1735610171038-6266.jpeg", "event-1735610171041-54641.jpeg", "event-1735610171079-21805.jpeg", "event-1735610171080-77772.jpeg"]', false, false, 212, NULL, '2024-12-31 01:56:14');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (577, 'Shugborough Estate', '2024-12-14 00:00:00', '13:00:00', '17:00:00', 'Great Haywood', 'A blend of landscape, monuments, gardens and Georgian mansion.

We had lunch at the cafe and toured the mansion.
', 'Historic Houses & Castles', '["event-1735778460381-23539.jpeg", "event-1735778419893-96259.jpeg", "event-1735778419899-7838.jpeg", "event-1735778419905-41898.jpeg", "event-1735778419911-5247.jpeg"]', false, NULL, 17, NULL, '2025-01-02 00:40:20');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (578, 'Xmas at Peel', '2024-12-24 00:00:00', '00:00:00', '23:59:00', 'Isle of Man', 'Travelled to nans for xmas.

Mostly stayed in doors.

Jay, Kelly, Cork, Nikki and Cooper visited on the Saturday', 'Christmas', '["event-1735778712007-22776.jpeg", "event-1735778712014-87882.jpeg", "event-1735778712017-38155.jpeg", "event-1735778712019-90124.jpeg", "event-1735778794296-3557.jpeg"]', false, NULL, 17, NULL, '2025-01-02 00:45:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (579, 'Morden Hall Park', '2025-01-02 00:00:00', '13:00:00', '16:00:00', 'Morden', 'Beautiful National Trust park, great for walking. Has a lovely garden centre shop and cafe.

Steph and Lekan went for a nice walk on Stephs birthday.', 'Parks & Garden', '["event-1736045666064-99552.jpeg", "event-1736045297835-61336.jpeg", "event-1736045297839-344.jpeg", "event-1736045666070-66001.jpeg"]', false, NULL, 17, NULL, '2025-01-05 02:48:18');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (580, 'Steph''s Birthday', '2025-01-02 00:00:00', '00:00:00', '23:59:00', 'London', 'The Faboya family got together to celebrate Stephs 39th birthday', 'Birthday Party', '["event-1736045755173-99774.jpeg", "event-1736045755175-21763.jpeg", "event-1736045495037-16447.jpeg", "event-1736045556067-86813.jpeg", "event-1736045755176-96537.jpeg"]', true, NULL, 17, NULL, '2025-01-05 02:51:35');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (581, 'Osterley Park and House', '2025-01-03 00:00:00', '14:00:00', '17:30:00', 'Isleworth', 'We visited a National Trust Georgian estate and park in Middlesex.

The estate had plenty of Roman design, painting and history to enjoy.

We walked around the pond and visited the cafe for a quick snack and drinks.

Someone tried to steal lucy', 'Historic Houses & Castles', '["event-1736046206614-76136.jpeg", "event-1736046206620-62448.jpeg", "event-1736046206622-52209.jpeg", "event-1736046206623-63193.jpeg", "event-1736046206625-49713.jpeg"]', false, NULL, 17, NULL, '2025-01-05 03:03:27');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (582, 'Priory Park', '2025-01-04 00:00:00', '14:30:00', '17:00:00', 'Reigate', 'Another visit with Maya to Priory Park.

Was a cold day but the kids got to play in the playground, had pizza and choc drinks at the cafe and saw some friendly squirrels.

', 'Parks & Garden', '["event-1736046524892-88338.jpeg", "event-1736046524900-83038.jpeg", "event-1736046524903-13311.jpeg", "event-1736046524904-18144.jpeg", "event-1736046524907-71390.jpeg"]', false, false, 17, NULL, '2025-01-05 03:08:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (583, 'Joined WayzAway!', '2025-01-04 00:00:00', '21:00:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 236, NULL, '2025-01-05 13:00:30');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (584, 'Joined WayzAway!', '2025-01-06 00:00:00', '10:44:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 237, NULL, '2025-01-07 09:44:46');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (585, 'Joined WayzAway!', '2025-01-06 00:00:00', '20:27:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 238, NULL, '2025-01-07 19:27:51');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (588, 'Joined WayzAway!', '2025-01-30 00:00:00', '12:24:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 241, NULL, '2025-01-31 11:24:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (589, 'Joined WayzAway!', '2025-02-17 00:00:00', '15:07:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 242, NULL, '2025-02-17 15:07:27');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (592, 'Joined WayzAway!', '2025-03-08 00:00:00', '13:46:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 244, NULL, '2025-03-09 03:46:04');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (593, 'Joined WayzAway!', '2025-03-08 00:00:00', '18:02:00', '21:04:00', 'breendonk', 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Day Trips', '["event-1741539899584-42474.jpeg"]', false, NULL, 245, NULL, '2025-03-09 17:02:40');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (595, 'Joined WayzAway!', '2025-03-14 00:00:00', '21:56:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 247, NULL, '2025-03-15 20:56:06');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (596, 'Joined WayzAway!', '2025-03-20 00:00:00', '09:21:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 248, NULL, '2025-03-21 08:21:42');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (597, 'Joined WayzAway!', '2025-04-11 00:00:00', '10:38:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 249, NULL, '2025-04-12 08:38:11');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (599, 'Joined WayzAway!', '2025-04-13 00:00:00', '13:04:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 251, NULL, '2025-04-13 17:04:52');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (600, 'Joined WayzAway!', '2025-04-26 00:00:00', '12:46:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 252, NULL, '2025-04-27 10:46:54');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (601, 'Joined WayzAway!', '2025-05-16 00:00:00', '16:26:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 253, NULL, '2025-05-17 14:26:11');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (602, 'Joined WayzAway!', '2025-05-20 00:00:00', '14:40:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 254, NULL, '2025-05-21 12:40:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (604, 'Umberslade farm', '2025-02-01 00:00:00', '00:00:00', '23:59:00', 'Solihull', 'Took Zoe and Isabel to the free farm. Not too many animals out at this time of the year but we stopped at the cafe for a drink and enjoyed the playground', 'Animal and Wildlife', '["event-1748645508486-58135.jpeg", "event-1748645508521-59315.jpeg", "event-1748645508574-70113.jpeg", "event-1748645508628-31451.jpeg", "event-1748645508695-187.jpeg"]', false, NULL, 17, NULL, '2025-05-30 22:51:53');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (605, 'Train to Derby', '2025-03-15 00:00:00', '12:00:00', '18:30:00', 'Derby', 'Zoe and Daddy took train to Derby to pick up new car', 'Family', '["event-1748646156235-52644.jpeg", "event-1748646156264-11456.jpeg"]', false, NULL, 17, NULL, '2025-05-30 23:02:37');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (606, 'Hartlebury Common', '2025-03-25 00:00:00', '16:00:00', '17:30:00', 'Hartlebury', 'Lilt first walk 🥰 The whole family went for a short walk in Harltebury Common', 'Nature Walks', '["event-1748646919716-77251.jpeg", "event-1748646919744-75548.jpeg", "event-1748646919788-45054.jpeg", "event-1748646919806-47478.jpeg", "event-1748646919814-20280.jpeg"]', false, NULL, 17, NULL, '2025-05-30 23:15:21');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (607, 'Twycross Zoo', '2025-03-29 00:00:00', '00:00:00', '23:59:00', 'Atherstone', 'Family day out to Twycross Zoo', 'Animal and Wildlife', '["event-1748732078380-68301.jpeg"]', false, NULL, 17, NULL, '2025-05-31 22:54:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (608, 'Joined WayzAway!', '2025-06-15 00:00:00', '22:52:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 256, NULL, '2025-06-16 20:52:12');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (610, 'Joined WayzAway!', '2025-06-20 00:00:00', '15:10:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 258, NULL, '2025-06-21 13:10:44');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (612, 'Joined WayzAway!', '2025-06-25 00:00:00', '20:35:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 260, NULL, '2025-06-26 18:35:17');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (614, 'Burlish Meadows', '2025-05-09 00:00:00', '16:00:00', '18:00:00', 'Stourport ', 'Family walk ina peaceful quiet park', 'Parks & Garden', '["event-1751415988748-64809.jpeg"]', false, NULL, 17, NULL, '2025-07-02 00:25:46');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (615, 'Little Owl Farm', '2025-05-31 00:00:00', '12:00:00', '03:00:00', 'Dunhampton', 'Family day out to little owl farm with nanny and grandad', 'Animal and Wildlife', '["event-1751417099944-5723.jpeg", "event-1751417099951-53961.jpeg", "event-1751416361594-11514.jpeg", "event-1751416361635-98117.jpeg", "event-1751417099953-83631.jpeg"]', false, NULL, 17, NULL, '2025-07-02 00:32:45');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (616, 'Golf', '2025-06-14 00:00:00', '12:00:00', '17:00:00', 'Ravenmeadow', '18 holes with Dan, Kudz and Ben', 'Outdoor Activities', '["event-1751416554673-3545.jpeg"]', false, NULL, 17, NULL, '2025-07-02 00:35:55');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (617, 'Atwell Farm', '2025-05-17 00:00:00', '00:00:00', '23:59:00', 'Redditch', 'Day out at Atwell Farm', 'Animal and Wildlife', '["event-1751416926501-11040.jpeg", "event-1751416926541-11840.jpeg", "event-1751416926544-57082.jpeg", "event-1751416926553-26858.jpeg", "event-1751416926555-11431.jpeg"]', false, NULL, 17, NULL, '2025-07-02 00:42:07');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (618, 'Joined WayzAway!', '2025-07-04 00:00:00', '15:52:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 262, NULL, '2025-07-05 13:52:24');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (619, 'Joined WayzAway!', '2025-07-05 00:00:00', '07:06:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 263, NULL, '2025-07-06 07:06:32');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (620, 'Joined WayzAway!', '2025-07-15 00:00:00', '12:33:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 264, NULL, '2025-07-16 10:33:00');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (621, 'Joined WayzAway!', '2025-07-19 00:00:00', '20:55:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 265, NULL, '2025-07-20 18:55:31');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (622, 'Sixways Summer Bash', '2025-07-19 00:00:00', '13:00:00', '18:30:00', 'Worcester', 'Summer event held by Worcester Rugby club at the six ways stadium. Music, drinks, foods and Summer games. Was a nice day out, nice weather and got chased by the wasps which Isabel found funny', 'Outdoor Activities', '["event-1753303383411-28002.jpeg", "event-1753303383492-73068.jpeg", "event-1753303383498-66333.jpeg", "event-1753303383501-51013.jpeg", "event-1753303383505-35967.jpeg"]', false, NULL, 17, NULL, '2025-07-23 20:43:04');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (623, 'Imagination Street', '2025-08-04 00:00:00', '13:00:00', '16:00:00', 'Redditch ', 'Play centre. Isabel and Zoe had a great time going through the play course. ', 'Indoor Activities', '["event-1754518738374-14650.jpeg", "event-1754518738380-42282.jpeg", "event-1754518774731-78621.jpeg"]', false, NULL, 17, NULL, '2025-08-06 22:19:00');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (624, 'Abbey Park', '2025-08-02 00:00:00', '15:00:00', '18:00:00', 'Evesham', 'Evesham battle reenactment and paddle park ', 'Parks & Garden', '["event-1754519100120-61152.jpeg"]', false, NULL, 17, NULL, '2025-08-06 22:25:01');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (625, 'Fruit Picking', '2025-08-05 00:00:00', '14:30:00', '17:00:00', 'Stourport on Severn', 'Fruit and vegetable picking at Bells Farm', 'Outdoor Activities', '["event-1754519245292-84962.jpeg", "event-1754519245292-27737.jpeg", "event-1754519245294-72970.jpeg", "event-1754519245297-85412.jpeg", "event-1754519245298-11130.jpeg"]', false, NULL, 17, NULL, '2025-08-06 22:27:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (626, 'Conkers', '2025-08-06 00:00:00', '14:30:00', '18:00:00', 'Swadlincote ', 'Outdoor activities and walks for the family. Zoe and Isabel enjoyed the activity trail', 'Outdoor Activities', '["event-1754522087903-27252.jpeg", "event-1754522087910-42947.jpeg", "event-1754519591874-8798.jpeg", "event-1754519591880-87227.jpeg"]', false, NULL, 17, NULL, '2025-08-06 22:32:22');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (627, 'Coombe Abbey Park', '2025-06-28 00:00:00', '13:00:00', '16:00:00', 'Coventry', 'Had a nice walk and sat on blanket under tree. The girls enjoyed running around and playing football.', 'Parks & Garden', '["event-1754519965473-13375.jpeg", "event-1754519965476-53052.jpeg", "event-1754519965477-14895.jpeg", "event-1754519965480-29809.jpeg", "event-1754520018022-79663.jpeg"]', false, NULL, 17, NULL, '2025-08-06 22:39:26');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (628, 'A Walk Through History', '2025-05-11 00:00:00', '14:00:00', '17:00:00', 'Worcester Woods County Park', 'A walk through military history. Bouncy castle and play park', 'Parks & Garden', '["event-1754520626379-66933.jpeg"]', false, NULL, 17, NULL, '2025-08-06 22:49:33');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (629, 'Hockerhill', '2025-05-10 00:00:00', '13:00:00', '17:00:00', 'Brewood', 'Indoor and outdoor play centre for kids', 'Play Centres', '["event-1754521967400-76614.jpeg", "event-1754521967413-28895.jpeg"]', false, NULL, 17, NULL, '2025-08-06 23:12:48');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (630, 'Play360', '2025-04-14 00:00:00', '12:00:00', '16:00:00', 'Redditch ', 'Indoor play centre', 'Play Centres', '["event-1754522051321-16089.jpeg"]', false, NULL, 17, NULL, '2025-08-06 23:14:11');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (631, 'Hicks Lodge', '2025-05-05 00:00:00', '13:00:00', '16:00:00', 'Swadlincote ', 'Bike riding park part of Forestry England.

Zoe bought her bike', 'Parks & Garden', '["event-1754522558194-93798.jpeg", "event-1754522558208-76664.jpeg"]', false, NULL, 17, NULL, '2025-08-06 23:22:38');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (632, 'Burlish Park', '2025-04-20 00:00:00', '16:00:00', '18:00:00', 'Stourport on Severn', 'Went for a family walk', 'Parks & Garden', '["event-1754522678541-48575.jpeg", "event-1754522678554-91926.jpeg"]', false, NULL, 17, NULL, '2025-08-06 23:24:39');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (633, 'Clent Hills', '2025-04-26 00:00:00', '16:00:00', '17:00:00', 'Clent', 'Quick walk with nanny', 'Nature Walks', '["event-1754522792580-77142.jpeg", "event-1754522792593-65209.jpeg"]', false, NULL, 17, NULL, '2025-08-06 23:26:33');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (635, 'Wyre Forest', '2025-04-18 00:00:00', '12:00:00', '14:00:00', 'Bewdley', 'Dad went on a walk with Zoe and Isabel', 'Nature Walks', '["event-1754522893925-68585.jpeg", "event-1754522893931-71549.jpeg"]', false, NULL, 17, NULL, '2025-08-06 23:28:14');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (636, 'Cannon Hill', '2025-04-10 00:00:00', '14:00:00', '17:00:00', 'Birmingham', 'Walk in the park and fun on the rides', 'Parks & Garden', '["event-1754523063610-11902.jpeg", "event-1754523063638-14616.jpeg"]', false, NULL, 17, NULL, '2025-08-06 23:31:04');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (637, 'Play 360', '2025-08-07 00:00:00', '14:00:00', '17:00:00', 'Redditch', 'Took the girls out for a run about in play 360.

Had a pizza and burger for lunch', 'Play Centres', '["event-1754698058054-89944.jpeg", "event-1754698058497-64477.jpeg", "event-1754698171816-62692.jpeg", "event-1754698131983-77073.jpeg", "event-1754698131984-96384.jpeg"]', false, NULL, 17, NULL, '2025-08-09 00:07:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (638, 'War Memorial Park', '2025-08-09 00:00:00', '18:00:00', '19:15:00', 'Stourport-on-Severn', 'Saturday evening. Went to the park so the kids could play. Isabel enjoyed the slides', 'Parks & Garden', '["event-1754819324283-83603.jpeg", "event-1754819324326-78591.jpeg"]', false, NULL, 17, NULL, '2025-08-10 09:48:47');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (639, 'Playland & Treasure Island', '2025-08-12 00:00:00', '14:00:00', '18:00:00', 'Stourport on Severn', 'Went out with Yas, Stuart and Nala.

Enjoyed mimi golf and some children''s ride at playland. Then went to Treasure  Island for a few more of the bigger rides.', 'Theme & Amusement Parks', '["event-1755048774478-21109.jpeg", "event-1755048774485-27449.jpeg", "event-1755048857024-67526.jpeg", "event-1755048857025-11765.jpeg", "event-1755048880790-24487.jpeg"]', false, NULL, 17, NULL, '2025-08-13 01:32:55');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (640, 'Joined WayzAway!', '2025-08-12 00:00:00', '20:56:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 266, NULL, '2025-08-13 19:56:21');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (641, 'Legoland', '2025-08-17 00:00:00', '08:00:00', '18:00:00', 'Windsor', 'Steph organised a trip to  legoland amusement for the family including Fayoke, Gbenga, the boys, Maya, Seun and Temi.

Nice stayed home with Nanny', 'Theme & Amusement Parks', '["event-1755556637398-61156.jpeg", "event-1755556637404-58523.jpeg", "event-1755556637407-74038.jpeg", "event-1755556637408-84608.jpeg", "event-1755556637409-90982.jpeg"]', false, NULL, 17, NULL, '2025-08-18 22:37:19');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (642, 'Manor Park', '2025-08-18 00:00:00', '17:00:00', '18:00:00', 'Stourport-on-Severn ', 'Went out with the girls and Maya to Manor park for an evening run around. The girls enjoyed the playground and the nice walk', 'Parks & Garden', '["event-1755557496533-13141.jpeg", "event-1755557496572-32599.jpeg", "event-1755557496596-27902.jpeg"]', false, NULL, 17, NULL, '2025-08-18 22:51:41');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (643, 'Swimming at Malvern Leisure Centre', '2025-08-19 00:00:00', '12:00:00', '13:15:00', 'Malvern', 'Took the girls and Maya to swim at Malvern. The pool had waves and slides. Isabel was moody at first but soon Perked up. She enjoyed the small slide in the pool', 'Water Activities', '["event-1755650983540-5452.jpeg", "event-1755650983547-15403.jpeg", "event-1755650983550-98955.jpeg"]', false, NULL, 17, NULL, '2025-08-20 00:49:44');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (644, 'War Memorial Park', '2025-08-21 00:00:00', '17:30:00', '18:40:00', 'Stourport-on-Severn ', 'Isabel, Zoe and Maya to the park.', 'Parks & Garden', '["event-1755827095209-71185.jpeg", "event-1755827095217-18330.jpeg", "event-1755827095275-13856.jpeg", "event-1755827095279-64811.jpeg", "event-1755827095282-50571.jpeg"]', false, NULL, 17, NULL, '2025-08-22 01:44:57');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (645, 'Joined WayzAway!', '2025-08-24 00:00:00', '00:40:00', NULL, NULL, 'Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.', 'Registration', '[]', false, NULL, 267, NULL, '2025-08-24 22:40:25');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (646, 'Arrow Valley Park', '2025-08-20 00:00:00', '14:00:00', '17:00:00', 'Redditch', 'Nice park with decent playground. Had pizza and ice cream at outside cafe. Isabel cried a lot because she couldn''t have another ice lolly. Maya came with us.', 'Parks & Garden', '["event-1756171195418-62110.jpeg", "event-1756171195422-5939.jpeg", "event-1756171195426-86028.jpeg", "event-1756171195430-31381.jpeg", "event-1756171195434-48081.jpeg"]', false, NULL, 17, NULL, '2025-08-26 01:19:56');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (647, 'Brinton Park', '2025-08-24 00:00:00', '14:00:00', '17:00:00', 'Kidderminster ', 'Splash pad and park ', 'Water Activities', '["event-1756171503524-94379.jpeg", "event-1756171503531-1964.jpeg", "event-1756171503537-99243.jpeg", "event-1756171503548-69570.jpeg", "event-1756171503555-27434.jpeg"]', false, NULL, 17, NULL, '2025-08-26 01:25:05');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (648, 'Family Fun Day', '2025-08-25 00:00:00', '15:00:00', '16:30:00', 'Tenbury Wells', 'Family fun day for charity. The girls played in the ball pit and sand pit. Was a nice day so was good to get out', 'Outdoor Activities', '["event-1756171676686-11149.jpeg", "event-1756171676694-52040.jpeg", "event-1756171676697-38882.jpeg", "event-1756171676702-61809.jpeg", "event-1756171676705-55031.jpeg"]', false, NULL, 17, NULL, '2025-08-26 01:27:57');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (649, 'Geoff and Hayleys Wedding Party', '2025-08-30 00:00:00', '16:30:00', '20:30:00', 'Norton Canon Village Hall', 'Geoff and Hayley got married in May but had a small party for friends and family in their village hall. They had a small bouncy castle for kids and a hog roast. ', 'Special Occasions', '["event-1756598042340-71280.jpeg", "event-1756598042575-68215.jpeg", "event-1756598042597-24518.jpeg", "event-1756598042604-94396.jpeg", "event-1756598042606-69361.jpeg"]', false, NULL, 17, NULL, '2025-08-30 23:54:04');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (650, 'Stourport Festival', '2025-09-06 00:00:00', '18:00:00', '21:00:00', 'Stourport-on-Severn ', '2025 festival.

Walked into town via the canal to enjoy the live music, rides and the Nutella treats.

', 'Family', '["event-1757413228112-99306.jpeg", "event-1757413228154-55881.jpeg", "event-1757413228158-56320.jpeg", "event-1757413228173-90531.jpeg", "event-1757413228206-48972.jpeg"]', false, NULL, 17, NULL, '2025-09-09 10:20:33');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (651, 'Berzerk Active Play  ', '2025-09-08 00:00:00', '14:00:00', '15:00:00', 'King Heath', 'Formerly Hickory Dickory.

We took Isabel and lily.

It was Lily first time visiting.', 'Play Centres', '["event-1757413631000-54517.jpeg", "event-1757413688335-92993.jpeg", "event-1757413688343-67885.jpeg", "event-1757413688346-31255.jpeg", "event-1757413710416-13804.jpeg"]', false, NULL, 17, NULL, '2025-09-09 10:27:11');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (652, 'Hartlebury Castle', '2025-09-13 00:00:00', '15:30:00', '18:00:00', 'Hartlebury', 'Tour around Hartlebury castle and museum', 'Historic Houses & Castles', '["event-1758152209433-65978.jpeg", "event-1758152209449-24599.jpeg", "event-1758152209456-11015.jpeg", "event-1758152209460-71065.jpeg", "event-1758152209461-98866.jpeg"]', false, NULL, 17, NULL, '2025-09-17 23:36:50');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (654, 'Zoe Harvest Festival', '2025-10-03 00:00:00', '14:30:00', '15:15:00', 'Wilden Church', 'Went to seee Zoe sing at Wilden church for the Harvest festival.', 'Special Occasions', '["event-1760224842806-43194.jpeg"]', false, NULL, 17, NULL, '2025-10-11 23:20:43');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (655, 'Canon Hill Park', '2025-10-11 00:00:00', '16:00:00', '17:00:00', 'Birmingham ', 'Quick walk and Ice cream with Isabel', 'Parks & Garden', '["event-1760224985683-30049.jpeg", "event-1760224985714-67369.jpeg", "event-1760224985752-18671.jpeg", "event-1760224985792-83982.jpeg"]', false, NULL, 17, NULL, '2025-10-11 23:23:10');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (656, 'Taiwa 8th Birthday Party', '2025-10-11 00:00:00', '15:15:00', '17:30:00', 'Birmingham', 'Taika invited Zoe to his birthday at Brandwood centre.

Isabel and Dad joined later', 'Birthday Party', '["event-1760225152730-92825.jpeg", "event-1760225152732-95853.jpeg", "event-1760225152738-33047.jpeg", "event-1760225152739-39462.jpeg"]', false, NULL, 17, NULL, '2025-10-11 23:25:53');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (657, 'Twycross Zoo', '2025-10-18 00:00:00', '14:30:00', '18:00:00', 'Atherstone ', 'Family day out at the Zoo', 'Family Attractions', '["event-1761181299610-49975.jpeg", "event-1761181299619-69236.jpeg", "event-1761181299621-54119.jpeg", "event-1761181299623-48338.jpeg", "event-1761181299626-33737.jpeg"]', false, NULL, 17, NULL, '2025-10-23 01:01:40');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (658, 'Sea Life', '2025-10-25 00:00:00', '12:30:00', '13:30:00', 'Birmingham', 'While family including Nan went to sea life. It was Lily first visit. We stopped at Costa after.', 'Family Attractions', '["event-1761848220741-79061.jpeg", "event-1761848220842-76809.jpeg", "event-1761848220935-70710.jpeg", "event-1761848221036-50510.jpeg"]', false, NULL, 17, NULL, '2025-10-30 18:17:09');
INSERT INTO public.event_post (id, title, date, start_time, end_time, location, description, category, images, is_featured, new_notification, user_id, expires_at, created_at) VALUES (461, 'Friend''s event 2', '2024-07-17 00:00:00', '00:00:00', '23:59:00', 'MF', 'asdf lksjadf lksajdflas lkasdjf', 'Concerts', '["event-1720929987357-1508.jpeg", "event-1758706749780-98027.jpeg", "event-1758706749783-96736.jpeg", "event-1758706749786-11432.jpeg", "event-1758706749790-88165.jpeg"]', true, true, 53, NULL, '2024-07-08 06:50:30');


--
-- Data for Name: event_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (20, 194, 38, 'After so long we finally off to New Zealand.  First few days is all about getting there.  ', '2023-11-10 21:11:17');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (21, 194, 43, '??????', '2023-11-14 19:08:28');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (22, 194, 43, 'Oh it doesn’t like emojis…', '2023-11-14 19:08:48');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (23, 194, 43, 'Have an amazing time and happy flightings!', '2023-11-14 19:09:38');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (25, 194, 38, 'Travel to the airport was a breeze. Not sure about the 5 hrs to kill before we fly!', '2023-11-14 23:35:29');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (26, 199, 38, 'We have arrived after a long couple of flights, tired but happy to be here.  We arrived in time to get out and into Auckland to get our bikes arranged and a chance to explore the town, the Albert park and stop for a bite to eat in the marina water front area and relax.  Tomorrow we collect our camper and start the tour of New Zealand.....cant wait but must get some much needed sleep.', '2023-11-16 14:37:45');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (28, 181, 29, 'Nice', '2023-11-16 18:25:42');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (29, 199, 44, 'Pleased to hear you''ve arrived safely - let the adventures begin!! ?', '2023-11-17 01:54:44');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (31, 200, 38, '04.30 wide awake, not bad i guess head hit the pillow and out for the count at 21.30. Down for breakfast, so much to choose from but  a good breakfast before a busy day.

A beautiful start to the day, 07.30 and already 21  degrees.

Head off for the shuttle bus to drop us at the campervan hire only to find they don''t go as far as this, taxi it is (at least this should be the last one we take....yes they are not the cheapest of transport! But hey we are on holiday!) 
After a little wait for the camper we finally got our tour before being left on our own. first impression, boy it''s massive .. and with that we loaded the suitcases, securely of course and set off to pick up the bikes.  

Graham got the bikes on the bike rack, and we were off to start this 3 week adventure and first stop, which i have to say i''m very excited for....... Hobbiton.

Just over 2 hours journey, the drizzle started but a lovely scenic drive, we are loving seeing the art work road side, hard to take photos as moving but couple of pictures did get taken. 

Hobbiton you didn''t disappoint, our tour guide Nathaniel was extremely funny and knowledgeable, boarded the coach that takes you the 10 mins across the working farm land to the hidden gem of hobbiton. Peter Jackson built and rebuilt hobbiton for the first 3 movies before finally realizing it needed to be permanent, before working with the owner of the farm and the New Zealand government to make this accessable for the public to enjoy. It felt very surreal walking around a site of films we''ve watched many times, and yes we will be watching them when we get home.  the rain stopped and started throughout but 2 hours later we headed to The Dragon Rest for a cider then it was time to head back to the coach :( 

After a spot of lunch in the cafe we headed off to find the recommended Pack ''n'' Save supermarket to stock up on provision oh and some food.

First camp site is Blue Lake, Rotorua. Driving through the Redwoods- Whakarewarewa Forest was amazing to have then spectacular views of the lake from the site, sadly weather hasn''t started as we would of liked so photos of the lake don''t do it justice. 

Evening spent sorting out unpacking the cases and cooking our first meal. ', '2023-11-18 11:25:12');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (32, 201, 38, ' First night sleeping in the campervan must say wasn''t that bad,  it rained all night, but bit longer sleep...

This morning we were heading off to attend the Puarenga Park,  Rotorua Park run, 8am start unlike UK 9am start. 70 runners finished the race, Graham 28th parkrun first one at Puarenga Park sadly probably his only one, but as a sight seeing parkrun finished 16th. 3 people from the UK, couple we meet who were picking up there camper at the same time. 

The car park for this event was at the Te Karapu o Whakarewarewa Rugby Club, so would of been rude to just not stay after the race and use the car park for us to cook breakfast before heading off to the spa. 

Next stop on the itinerary is the Polynesian Spa, Rotorua. Anniversary treat, booked ourselves the Ultimate Double Dipper.  This was an experience, geothermal hot springs, this was just what was needed to refresh. such an experience each pool hotter than the the last from 36 degrees to 41 degrees. A well worth visit, followed by a free smoothie and maybe a spot of lunch.

The drive from the spa to our next campsite was another scenic route, sadly the rain masked much of the scenery, rolling hills and its all very green land. The many forms of culturally art work on route continued. As we got off the state highway we headed down towards Lake Taupo and this final bit of driving was very pretty driving along the lake until reached our second campsite, which we are staying 2 nights at. 

Motutere Bay will be our base for the next 2 nights, yet again friendly check in staff, even moved us so we were at a quieter spot....not sure what she meant!! But we are right on the lake, literally almost due to my navigating Graham reversing the camper.. so after avoiding Graham reversing into the lake we cracked open the wine and I caught up on the journal while graham cooked curry. ', '2023-11-18 12:56:27');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (33, 201, 45, 'Views over that lake look incredible!!!', '2023-11-18 21:18:32');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (34, 182, 28, 'hello', '2023-11-28 04:54:20');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (35, 182, 28, 'How are you', '2023-11-28 04:54:25');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (36, 220, 49, 'hi:)
', '2023-11-28 13:24:04');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (44, 182, 29, 'test', '2023-12-18 06:38:15');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (45, 182, 29, '💌', '2023-12-18 06:38:34');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (46, 182, 29, '😊', '2023-12-18 06:39:05');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (47, 42, 17, '😎', '2023-12-18 20:11:56');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (51, 228, 56, '🤩', '2023-12-21 09:10:45');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (58, 400, 130, 'Test', '2024-06-10 02:38:37');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (59, 400, 130, 'F', '2024-06-10 02:38:55');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (60, 455, 184, 'This is my private journal', '2024-07-06 21:58:58');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (63, 461, 130, 'Looks delicious 😋 ', '2024-07-14 04:42:37');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (64, 370, 1, 'asdfee', NULL);
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (66, 568, 215, 'I assisted Karim''s second', '2024-12-09 17:35:02');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (67, 576, 1, 'Test', '2025-01-20 03:25:00');
INSERT INTO public.event_comment (id, event_id, user_id, text, created_at) VALUES (68, 582, 1, 'Test', '2025-01-20 03:25:40');


--
-- Data for Name: comment_mention; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: event_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_category (id, name) VALUES (23, 'Weekend Away');
INSERT INTO public.event_category (id, name) VALUES (24, 'Water Activities');
INSERT INTO public.event_category (id, name) VALUES (25, 'Tours');
INSERT INTO public.event_category (id, name) VALUES (26, 'Theme & Amusement Parks');
INSERT INTO public.event_category (id, name) VALUES (27, 'Theatre');
INSERT INTO public.event_category (id, name) VALUES (28, 'Sport & Leisure');
INSERT INTO public.event_category (id, name) VALUES (29, 'Sport Events');
INSERT INTO public.event_category (id, name) VALUES (30, 'Play Centres');
INSERT INTO public.event_category (id, name) VALUES (31, 'Parks & Garden');
INSERT INTO public.event_category (id, name) VALUES (32, 'Outdoor Activities');
INSERT INTO public.event_category (id, name) VALUES (33, 'Other');
INSERT INTO public.event_category (id, name) VALUES (34, 'Nature Walks');
INSERT INTO public.event_category (id, name) VALUES (35, 'Museums & Exhibitions');
INSERT INTO public.event_category (id, name) VALUES (36, 'Live Shows');
INSERT INTO public.event_category (id, name) VALUES (37, 'Landmarks & Monuments');
INSERT INTO public.event_category (id, name) VALUES (38, 'Indoor Activities');
INSERT INTO public.event_category (id, name) VALUES (39, 'Holidays');
INSERT INTO public.event_category (id, name) VALUES (40, 'Historic Houses & Castles');
INSERT INTO public.event_category (id, name) VALUES (41, 'General');
INSERT INTO public.event_category (id, name) VALUES (42, 'Food & Drinks');
INSERT INTO public.event_category (id, name) VALUES (43, 'Family Attractions');
INSERT INTO public.event_category (id, name) VALUES (44, 'Educational');
INSERT INTO public.event_category (id, name) VALUES (45, 'Day Trips');
INSERT INTO public.event_category (id, name) VALUES (46, 'Culture & History');
INSERT INTO public.event_category (id, name) VALUES (47, 'Concerts');
INSERT INTO public.event_category (id, name) VALUES (48, 'Arts & Craft');
INSERT INTO public.event_category (id, name) VALUES (49, 'Animal and Wildlife');
INSERT INTO public.event_category (id, name) VALUES (50, 'Adventure Activities');
INSERT INTO public.event_category (id, name) VALUES (51, 'Christmas');
INSERT INTO public.event_category (id, name) VALUES (52, 'Family');
INSERT INTO public.event_category (id, name) VALUES (53, 'Friends');
INSERT INTO public.event_category (id, name) VALUES (54, 'Birthday Party');
INSERT INTO public.event_category (id, name) VALUES (55, 'Special Occasions');


--
-- Data for Name: event_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_collection (id, user_id, name, description, color, icon, created_at, updated_at) VALUES (1, 53, 'koko', '', '#388e3c', 'mdi-camera', '2025-11-07 13:23:06.251', '2025-11-07 13:23:06.251');


--
-- Data for Name: event_collection_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_collection_item (id, user_id, event_id, collection_id, created_at) VALUES (1, 53, 461, 1, '2025-11-07 13:23:09.821');


--
-- Data for Name: user_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_group (id, user_id, name, description, color, icon, created_at) VALUES (1, 53, 'kko', '', '#388e3c', 'mdi-soccer', '2025-11-07 13:21:36.155');


--
-- Data for Name: event_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_group (id, event_id, group_id, shared_by, created_at) VALUES (1, 461, 1, 53, '2025-11-07 13:21:38.859');


--
-- Data for Name: event_reaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_reaction (id, user_id, event_id, reaction_type, created_at) VALUES (1, 53, 461, 'like', '2025-11-07 13:21:21.96');


--
-- Data for Name: event_wishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (6, 'test', 'asdfsdf', 'asdfsadf', 'Sport', '["event-1758706109261-42153.jpeg", "event-1758706109265-86887.jpeg"]', 1, '2023-10-24 08:51:38');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (7, 'Clent Hills', 'Clent', 'Scenic Walk', 'Nature Walks', NULL, 17, '2023-10-25 07:24:50');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (8, 'Lickey Hills', 'Cofton', 'Scenic Walk', 'Nature Walks', NULL, 17, '2023-10-25 07:25:23');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (9, 'Cadbury Factory', 'Bournville ', 'Museum', 'Museums & Exhibitions', NULL, 17, '2023-10-25 07:26:57');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (10, 'Chasewater', 'Brownhill', 'Walk around lake', 'Parks & Garden', NULL, 17, '2023-10-25 07:28:17');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (12, 'Shustoke Reservoir', 'Coleshill', 'Walk around the lake', 'Nature Walks', NULL, 17, '2023-10-25 07:31:48');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (13, 'Kingsbury Water Park', 'Sutton Coldfield', 'Walk around the lake', 'Parks & Garden', NULL, 17, '2023-10-25 07:33:27');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (14, 'Leasowes Park', 'Halesowen', 'English heritage parkland', 'Parks & Garden', NULL, 17, '2023-10-25 07:34:48');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (15, 'Cannock Chase Forest', 'Rugeley', 'Woodland forest', 'Parks & Garden', NULL, 17, '2023-10-25 07:36:52');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (16, 'Severn Valley Railway', 'Kidderminster', 'Steam railway', 'Culture & History', NULL, 17, '2023-10-25 07:38:38');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (17, 'Boscobel House', 'Shropshire', 'English Heritage', 'Historic Houses & Castles', '["event-1705716472702-38114.jpeg"]', 17, '2023-10-25 07:40:14');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (20, 'Mill Garden', 'Leamington Spa', 'Park and Garden. CV31 1BB', 'Parks & Garden', NULL, 17, '2023-11-08 16:20:07');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (21, 'Foundry Woods', 'Leamington Spa', 'Community Woodland. CV31 3PH', 'Parks & Garden', NULL, 17, '2023-11-08 16:21:16');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (22, 'Jephsons Gardens', 'Leamington Spa', 'Historical Garden. CV32 4AA', 'Parks & Garden', NULL, 17, '2023-11-08 16:22:15');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (23, 'Pump Room Gardens', 'Leamington Spa', 'Historical Park Garden. CV32 4AA. Stop at Jephson Garden', 'Parks & Garden', NULL, 17, '2023-11-08 16:23:43');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (24, 'Victoria Park', 'Leamington Spa', 'Main Park in Leamington. CV31 3PH', 'Parks & Garden', NULL, 17, '2023-11-08 16:24:46');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (25, 'Newbold Comyn', 'Leamington Spa', '300 acres park. Has a old farmhouse that is now a pub, 33 metres swimming pool, cafe, chuldrens fun pool. CV32 4EW', 'Parks & Garden', NULL, 17, '2023-11-08 16:26:42');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (26, 'Knowle Lock', 'Knowle', 'Park on the car park on Hampton Road and access the towpath of the canal then follow it south to the canal bridge on Kenilworth Road and onto Kingswood.', 'Nature Walks', '[]', 17, '2023-12-16 19:23:45');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (27, 'Springfield Park', 'Kidderminster ', 'Park in middle of Kidderminster', 'Parks & Garden', '["event-1705397525919-74626.jpeg"]', 17, '2023-12-16 19:26:03');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (28, 'Warley Woods', 'Warley', 'Walk in the woods', 'Nature Walks', '["event-1705397450234-22227.jpeg"]', 17, '2023-12-16 19:27:54');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (29, 'Heronfield Animal Rescue Centre', 'Knowle', 'Small animals', 'Animal and Wildlife', '[]', 17, '2023-12-16 19:30:26');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (30, 'Carding Mill Valley', 'Church Stretton', 'Can drive to top of the hill', 'Nature Walks', '["event-1705397409994-42225.jpeg"]', 17, '2023-12-16 19:32:13');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (31, 'Plantsbrook Nature Reserve', 'Sutton Coldfield', 'Mostly Open Water', 'Nature Walks', '["event-1705397372990-43000.jpeg"]', 17, '2023-12-16 19:34:56');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (32, 'Calthorope', 'Wednesbury', 'New Park', 'Culture & History', NULL, 29, '2024-01-04 11:28:06');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (33, 'The Parks VR', 'Birmingham', 'VR Adventures', 'Indoor Activities', '["event-1705715775402-66879.jpeg"]', 17, '2024-01-20 08:56:15');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (34, 'Harvington Hall', 'Kidderminster', 'Historic House

Harvington,
Kidderminster,
Worcestershire
DY10 4LR', 'Historic Houses & Castles', '["event-1705716984645-79879.jpeg", "event-1705716984645-28194.jpeg"]', 17, '2024-01-20 09:16:25');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (35, 'Rosliston Forestry Centre', 'Rosliston', 'DE12 8JX
Burton Rd , Rosliston , Swadlincote', 'Nature Walks', '["event-1705717853598-98743.jpeg"]', 17, '2024-01-20 09:30:54');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (36, 'Dimmingsdale', 'Alton', 'Rolling countryside provides an abundance of woodland, streams, ponds and lakes 

ST10 4BU
Alton, Stoke-on-Trent', 'Nature Walks', '["event-1705718135159-66566.jpeg"]', 17, '2024-01-20 09:35:35');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (37, 'Cafe Craft', 'Bearwood', 'Art, painting, jewellery creation.

521 Bearwood Road
Bearwood
Birmingham
B66 4BE', 'Indoor Activities', '["event-1705719136635-96033.jpeg"]', 17, '2024-01-20 09:52:17');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (38, 'Hockerhill ', 'Staffordshire ST19 9BQ', 'Play area and adventure centre', 'Play Centres', '["event-1711191839194-33252.jpeg"]', 17, '2024-03-23 18:03:59');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (39, 'Rhea Valley Ride', 'Worcester', 'Boat ride', 'Concerts', '[]', 29, '2024-04-17 03:13:53');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (40, 'Habberley', 'Bromswood', 'Trail', 'Concerts', '[]', 29, '2024-04-17 03:14:32');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (41, 'Lickey Walk', 'Bromsgrove', 'Walk', 'Nature Walks', '[]', 29, '2024-04-17 03:15:04');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (42, 'Spot on Wake', 'Henley in Harden', 'Wootton Park, Wootton Wawen, Henley-in-Arden B95 6HJ', 'Water Activities', '["event-1715367471622-62884.jpeg"]', 17, '2024-05-11 01:57:52');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (43, 'Cliff Lakes', 'Tamworth', 'Tamworth Rd, Cliff, Tamworth B78 2DL', 'Water Activities', '["event-1715367575359-86506.jpeg"]', 17, '2024-05-11 01:59:36');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (45, 'Subtropical Swimming Paradise', 'Bedford', 'Woburn Forest, Fordfield Rd, Millbrook, Bedford MK45 2HZ', 'Water Activities', '["event-1715368199874-35220.jpeg", "event-1715368201775-46964.jpeg"]', 17, '2024-05-11 02:10:02');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (46, 'Box End Park', 'Bedford', 'Box End Rd, Box End, Bedford MK43 8RQ', 'Water Activities', '["event-1715368321112-72954.jpeg", "event-1715368321759-44934.jpeg"]', 17, '2024-05-11 02:12:03');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (47, 'Twinlakes Outdoor Waterpark', 'Mowbray', 'Melton Spinney Rd, Thorpe Arnold, Melton Mowbray LE14 4FF', 'Water Activities', '["event-1715368420648-80332.jpeg"]', 17, '2024-05-11 02:13:41');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (49, 'test', 'test', 'Test', 'Culture & History', '["event-1715394347608-18485.jpeg", "event-1715394347862-50309.jpeg"]', 29, '2024-05-11 09:25:48');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (50, 'Test', 'Test', 'Test', 'Culture & History', '["event-1715776796315-95399.jpeg", "event-1715776796403-89936.jpeg"]', 77, '2024-05-15 19:39:56');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (51, 'Test', 'Test', 'Test', 'Arts & Craft', '["event-1715995760981-11899.jpeg", "event-1715995762691-79202.jpeg"]', 77, '2024-05-18 08:29:23');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (52, 'Another', 'Another', 'Ok', 'Arts & Craft', '["event-1715995821288-28851.jpeg", "event-1715995821475-79354.jpeg"]', 77, '2024-05-18 08:30:21');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (53, 'July 2025 Trip To Canada', 'Canada', 'Dayrit Family reunion to Edmonton including trip to Banf and Lake Louise', 'Other', '[]', 109, '2024-05-19 10:17:39');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (54, 'December 2025 Trip to Spain', 'Spain', 'Plan trip to Madrid, Seville', 'Other', '[]', 109, '2024-05-19 10:18:22');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (55, 'August 2026 Highlights of Scandinavia', 'Sweden, Norway & Denmark', 'https://www.goaheadtours.com/guided-tours/highlights-of-scandinavia-sweden-norway-denmark
3839 per person

', 'Other', '[]', 109, '2024-05-19 10:28:35');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (56, 'December 2026 Australia and New Zealand', 'Australia and New Zealand', 'Australia and New Zealand include Fiji', 'Other', '[]', 109, '2024-05-19 10:29:44');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (57, 'June July 2027 Switzerland', 'Switzerland', 'Swtizerand Milan Lake Como', 'Other', '[]', 109, '2024-05-19 10:31:08');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (58, 'Gulliver Theme Park', 'Matlock Bath', 'Theme Park and Attraction for Family with kids

DE4 3PG', 'Adventure Activities', '["event-1716845057660-25972.jpeg"]', 17, '2024-05-28 04:24:17');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (59, 'National Space Centre', 'Leicester', 'Discover the wonders of space at the National Space Centre, a hub for space enthusiasts and educational opportunities.

LE4 5NS', 'Adventure Activities', '["event-1716845136211-74790.jpeg"]', 17, '2024-05-28 04:25:36');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (61, 'Swadlincote Snowsports Centre', 'Swadlincote', 'Tobagging and Drop slide

Swadlincote Snowsports Centre
Sir Herbert Wragg Way
Swadlincote
Derbyshire
DE11 8LP', 'Outdoor Activities', '["event-1719015938980-18902.jpeg", "event-1719015938984-35970.jpeg"]', 17, '2024-06-21 23:25:39');
INSERT INTO public.event_wishlist (id, title, location, description, category, images, user_id, created_at) VALUES (62, 'Isle of Man Locations', 'IOM', 'https://www.visitisleofman.com/', 'Holidays', '["event-1723493353002-67590.jpeg"]', 17, '2024-08-12 20:09:13');


--
-- Data for Name: friendship; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (22, 28, 29, '2023-11-09 22:43:27');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (23, 39, 38, '2023-11-11 20:03:04');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (24, 40, 38, '2023-11-11 20:12:39');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (26, 43, 38, '2023-11-14 19:03:19');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (27, 38, 41, '2023-11-15 00:04:51');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (28, 44, 38, '2023-11-15 01:44:24');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (29, 45, 38, '2023-11-18 14:40:26');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (34, 56, 17, '2023-12-21 09:10:23');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (35, 57, 17, '2023-12-22 00:27:39');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (37, 29, 76, '2024-01-02 09:14:48');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (38, 29, 77, '2024-01-02 09:15:26');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (46, 1, 40, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (47, 1, 41, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (49, 1, 43, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (50, 1, 44, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (51, 1, 45, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (52, 1, 46, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (54, 1, 48, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (55, 1, 49, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (56, 1, 50, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (57, 1, 51, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (59, 1, 53, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (63, 1, 57, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (64, 1, 58, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (65, 1, 59, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (66, 1, 60, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (67, 1, 61, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (68, 1, 62, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (69, 1, 63, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (71, 1, 65, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (72, 1, 66, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (73, 1, 67, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (74, 1, 68, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (76, 1, 70, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (77, 1, 71, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (78, 1, 72, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (79, 1, 73, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (80, 1, 74, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (81, 1, 75, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (83, 1, 77, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (85, 1, 87, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (89, 1, 94, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (91, 1, 96, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (92, 1, 97, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (94, 1, 99, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (95, 1, 100, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (96, 1, 101, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (97, 1, 102, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (98, 1, 103, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (99, 1, 105, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (100, 1, 106, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (101, 1, 107, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (103, 1, 109, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (104, 1, 111, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (105, 1, 112, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (106, 1, 113, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (107, 1, 114, '2024-05-30 03:02:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (180, 1, 39, '2024-05-30 03:27:25');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (181, 1, 47, '2024-05-30 03:27:25');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (184, 1, 56, '2024-05-30 03:27:25');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (185, 1, 64, '2024-05-30 03:27:25');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (191, 1, 17, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (192, 1, 28, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (193, 1, 29, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (194, 1, 38, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (195, 1, 69, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (196, 1, 76, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (197, 1, 88, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (198, 1, 91, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (199, 1, 98, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (200, 1, 108, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (201, 1, 119, '2024-05-30 04:22:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (204, 1, 124, '2024-05-30 16:52:57');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (205, 1, 125, '2024-06-01 10:54:14');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (206, 1, 126, '2024-06-01 23:33:45');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (207, 1, 127, '2024-06-01 23:47:41');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (208, 1, 128, '2024-06-02 07:39:22');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (209, 1, 129, '2024-06-02 19:54:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (210, 1, 130, '2024-06-06 17:28:30');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (229, 1, 165, '2024-06-13 13:47:52');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (233, 1, 169, '2024-06-14 07:51:20');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (236, 1, 172, '2024-06-28 03:43:04');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (237, 1, 173, '2024-06-28 10:53:14');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (246, 1, 181, '2024-07-03 18:05:50');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (249, 53, 130, '2024-07-04 08:07:41');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (250, 1, 184, '2024-07-06 18:53:00');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (257, 1, 187, '2024-07-12 16:21:31');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (258, 1, 188, '2024-07-13 02:03:49');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (259, 1, 189, '2024-07-14 04:00:44');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (260, 1, 190, '2024-07-15 16:24:50');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (261, 1, 191, '2024-07-17 19:52:58');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (262, 1, 192, '2024-07-29 11:57:21');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (264, 1, 194, '2024-08-15 21:20:25');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (265, 1, 195, '2024-08-19 08:01:37');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (266, 1, 196, '2024-08-20 14:36:25');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (267, 1, 197, '2024-08-24 14:34:11');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (268, 1, 198, '2024-08-27 09:00:53');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (269, 1, 199, '2024-08-27 21:44:39');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (270, 1, 200, '2024-08-28 08:50:43');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (271, 1, 201, '2024-09-01 03:27:35');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (272, 1, 202, '2024-09-05 10:06:33');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (274, 1, 204, '2024-09-10 22:02:53');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (275, 1, 205, '2024-09-24 12:50:44');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (276, 1, 206, '2024-09-28 21:29:03');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (277, 1, 207, '2024-10-12 16:54:56');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (278, 1, 208, '2024-10-13 05:19:23');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (279, 1, 209, '2024-10-14 21:58:37');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (280, 1, 210, '2024-10-15 01:15:33');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (281, 1, 211, '2024-10-20 11:42:21');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (282, 1, 212, '2024-10-21 13:53:15');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (284, 1, 213, '2024-10-22 05:25:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (285, 1, 214, '2024-10-23 17:45:44');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (286, 214, 212, '2024-10-23 17:45:44');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (287, 1, 215, '2024-10-23 17:52:19');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (288, 215, 212, '2024-10-23 17:52:19');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (289, 1, 216, '2024-10-23 18:30:52');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (290, 216, 212, '2024-10-23 18:30:52');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (291, 1, 217, '2024-10-23 18:48:27');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (292, 217, 212, '2024-10-23 18:48:27');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (293, 1, 218, '2024-10-23 19:08:21');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (294, 218, 212, '2024-10-23 19:08:21');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (295, 1, 219, '2024-10-23 20:14:46');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (296, 219, 212, '2024-10-23 20:14:46');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (297, 1, 220, '2024-10-23 20:59:07');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (298, 220, 212, '2024-10-23 20:59:07');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (300, 1, 222, '2024-10-24 13:37:59');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (301, 222, 212, '2024-10-24 13:37:59');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (302, 1, 223, '2024-10-25 09:23:27');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (303, 223, 212, '2024-10-25 09:23:27');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (304, 1, 224, '2024-10-25 20:28:38');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (305, 1, 225, '2024-10-26 10:19:06');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (306, 1, 226, '2024-10-27 20:48:51');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (307, 226, 212, '2024-10-27 20:48:51');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (308, 1, 227, '2024-11-03 20:43:01');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (309, 1, 228, '2024-11-13 04:35:09');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (310, 1, 229, '2024-11-18 19:57:02');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (311, 1, 230, '2024-11-20 10:59:08');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (312, 1, 231, '2024-11-24 21:41:10');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (313, 1, 232, '2024-11-27 15:48:54');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (314, 1, 233, '2024-11-29 11:17:43');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (315, 1, 234, '2024-12-12 05:40:42');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (316, 1, 235, '2024-12-25 00:42:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (317, 1, 236, '2025-01-05 13:00:30');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (318, 1, 237, '2025-01-07 09:44:45');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (319, 1, 238, '2025-01-07 19:27:50');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (320, 1, 239, '2025-01-25 17:03:54');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (322, 1, 241, '2025-01-31 11:24:12');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (323, 1, 242, '2025-02-17 15:07:26');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (324, 1, 243, '2025-03-04 12:57:38');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (325, 1, 244, '2025-03-09 03:46:03');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (326, 1, 245, '2025-03-09 17:02:39');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (328, 1, 247, '2025-03-15 20:56:05');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (329, 1, 248, '2025-03-21 08:21:42');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (330, 1, 249, '2025-04-12 08:38:10');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (331, 1, 250, '2025-04-12 22:06:59');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (332, 1, 251, '2025-04-13 17:04:52');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (333, 1, 252, '2025-04-27 10:46:53');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (334, 1, 253, '2025-05-17 14:26:10');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (335, 1, 254, '2025-05-21 12:40:44');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (337, 1, 256, '2025-06-16 20:52:11');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (339, 1, 258, '2025-06-21 13:10:44');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (341, 1, 260, '2025-06-26 18:35:16');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (343, 1, 262, '2025-07-05 13:52:24');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (344, 1, 263, '2025-07-06 07:06:31');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (345, 1, 264, '2025-07-16 10:32:59');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (346, 1, 265, '2025-07-20 18:55:31');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (347, 1, 266, '2025-08-13 19:56:21');
INSERT INTO public.friendship (id, user_id_1, user_id_2, created_at) VALUES (348, 1, 267, '2025-08-24 22:40:24');


--
-- Data for Name: group_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.group_member (id, group_id, user_id, role, joined_at) VALUES (1, 1, 53, 'owner', '2025-11-07 13:21:36.166');


--
-- Data for Name: invitation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (86, 196, 'Boone.c@live.com', '85b94d83-8cbc-4e5f-97ba-ffc2895323cd', false, '2024-08-20 14:39:01');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (88, 204, 'Catriona.barry@bigpond.com', '4fd8f243-9de1-4447-8fcb-566f0eda5561', false, '2024-09-10 22:05:39');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (89, 209, 'didiaffaires@gmail.com', '07f8df79-8332-43ff-8d37-8602e25aa1a4', false, '2024-10-14 21:59:35');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (90, 211, 'lev17@hotmail.com.au', '9703eab2-49fb-47a2-b0f4-0ef83266a98e', false, '2024-10-20 11:42:44');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (97, 212, 'adrianvarga697@gmail.com', '185bc285-1a1b-4a4d-bddc-d5680481bc12', false, '2024-10-23 15:50:24');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (99, 212, 'djlaurent3885@gmail.com', '1d553be7-fc7b-4ad0-abfc-9a41682cfb55', true, '2024-10-23 15:50:24');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (100, 212, 'mr.beaumont@live.com', 'bbe5ccd3-1eab-4240-8f47-1ee7d80c5007', false, '2024-10-23 15:50:24');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (102, 212, 'alexmoldrik@aol.com', '4dc84c56-3e3f-4396-8432-cfcb2f8a78a2', false, '2024-10-23 15:53:54');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (104, 212, 'badrinho@hotmail.co.uk', 'b764acc4-e29a-423e-9c7f-fc2521a304b3', false, '2024-10-23 15:53:54');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (106, 212, 'holmiedarg@gmail.com', '3206ef8a-55a1-4ff2-b1e0-7911fed1023d', false, '2024-10-23 15:53:54');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (108, 212, 'dovecurt@gmail.com', 'f7e55f78-cfe0-47d5-82d1-5144979027b4', false, '2024-10-23 16:00:15');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (109, 212, 'deanobeano_16_@hotmail.com', '6455b767-ca27-4927-91e8-0c5011ef6339', false, '2024-10-23 16:00:15');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (110, 212, 'efaboya12@gmail.com', 'b5b42480-b1f9-460f-984d-f7316bcb8714', false, '2024-10-23 17:21:56');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (111, 212, 'efaboya@hotmail.co.uk', 'eddda720-185f-46f9-ac28-3a9d82d2f741', false, '2024-10-23 17:21:57');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (112, 212, 'thefaboyas@outlook.com', 'd7525b12-1a3e-477c-8b17-c7c73f766054', false, '2024-10-23 17:21:57');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (113, 212, 'lfaboya12@gmail.com', '6e08abe3-48f1-4dfd-b014-8e7b43955b55', false, '2024-10-23 17:21:57');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (114, 212, 'Khalid-hussain89@hotmail.co.uk', '91c255d2-8ca2-4eb0-9370-197b34d55626', false, '2024-10-24 20:29:17');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (115, 212, 'jared.chantry@outlook.com', '6231a977-56d9-4fc5-8cba-d3a6bebaa756', false, '2024-10-24 20:29:17');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (116, 212, 'ngome89@hotmail.com', 'b3371145-cd07-4acd-870c-00b460ada0b3', true, '2024-10-24 20:29:17');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (117, 212, 'jlana@gmail.com', '54d70009-8039-4bc5-9a4c-2a79c3a72a66', false, '2024-10-24 20:29:17');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (118, 225, 'Dnorfrey@gmail.com', 'feed2563-fd81-47ab-b342-bd9c9bb0bb09', true, '2024-10-26 10:22:28');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (119, 225, 'Lisa.norfrey@gmail.com', '2c444de2-c4b1-451b-a7cb-6f7f07a635ac', false, '2024-10-26 10:22:28');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (120, 225, 'Jsinclair521@gmail.com', 'b45945bf-d099-4a0d-a857-7102cfa33478', false, '2024-10-26 10:22:28');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (121, 225, 'Norfrey.crista@gmail.com', 'c0a6f6f4-9aa9-4208-94d9-8560d6f0f945', false, '2024-10-26 10:22:28');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (122, 227, 'Hborys@gmx.de', '9f03c0a8-975b-46c6-bab0-9f20b14f70e7', false, '2024-11-03 20:43:13');
INSERT INTO public.invitation (id, sender_id, receiver_email, token, is_accepted, created_at) VALUES (123, 256, 'traudlgodmann@gmail.com', '7ffee4cb-131e-427c-a3ed-363b56605fd8', false, '2025-06-16 20:52:59');


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pages (id, title, description, name) VALUES (1, 'Landing', '[{"image": "page-1761166627016-22589.jpeg", "title": "A Private Home for Your Travel and Family Memories", "description": "Relive your best moments without the noise of social media.\n\nKeep your travels, family days out, and everyday moments safe from algorithms, ads, and public feeds. WayzAway is a private lifestyle and travel journal that makes capturing and organising your memories simple and secure."}, {"image": "page-1761166627041-31713.jpeg", "title": "Why WayzAway", "description": "Private Sharing\nShare moments only with the people who matter most. There are no public feeds, no strangers, and no unwanted attention.\n\nSimple to Use\nAdd photos, notes, and locations in seconds. The clean design makes it easy for anyone to capture and revisit memories.\n\nAccess Anywhere\nYour journal works on your phone, tablet, or computer, so you can record a memory wherever you are."}, {"image": "page-1761166627043-57727.jpeg", "title": "Perfect for Families, Travellers, and Memory-Keepers", "description": "WayzAway is ideal for families who want to document days out, birthdays, school trips, and holidays. It is perfect for travellers who want to keep a personal record of destinations, itineraries, and hidden gems. It also suits memory-keepers who enjoy journaling, scrapbooking, and organising life’s special moments.\n\nPlan and Share in Private\nPlan future journeys, invite friends and family to join, and share your favourite places without the noise of social media.\n\nCapture Moments in Seconds\nFrom weekend picnics to once-in-a-lifetime trips, add your memories quickly and easily, then revisit them whenever you want.\n\nKeep Memories Safe and Organised\nYour journal is securely stored and neatly organised, so nothing gets lost and everything is easy to find."}, {"image": "page-1720029189513-78261.jpeg", "title": null, "description": "Your Memories Deserve a Home\n\nEvery laugh, trip, and unforgettable day deserves to be remembered. Start free today and build your private lifestyle and travel journal.\n"}]', 'landing');
INSERT INTO public.pages (id, title, description, name) VALUES (2, 'Terms & Condition', '{"content": "Welcome to Wayzaway (\"We\"). These Terms & Conditions govern your use of our platform. By accessing or using Wayzaway, you agree to comply with and be bound by these terms. Please read them carefully.\n\nUser Registration:\nTo use Wayzaway, you must be at least 13 years old. If you are under 13, you are not permitted to register or use our services.\n\nWhen you register, you agree to provide accurate, current, and complete information, including your name, email address, password, date of birth, and country.\n\nUser Conduct:\nYou are responsible for all content you post, including events, comments, and messages. Do not post harmful, offensive, or misleading information.\n\nRespect the privacy of other users. Do not share personal information, such as addresses or phone numbers, without consent.\n\nDo not engage in harassment, bullying, or any form of harmful behaviour towards other users.\n\nYou may not use Wayzaway for any illegal or unauthorized purpose. You agree to comply with all applicable laws and regulations.\n\nPrivacy and Data Security:\nProtect your personal information and exercise caution when sharing it with other users.\n\nWayzaway takes data security seriously and employs measures to protect your information. However, we cannot guarantee absolute security.\n\nAccount Termination:\nWayzaway reserves the right to terminate or suspend your account, with or without cause, at any time.\n\nYou may delete your account at any time, which will result in the removal of your data from our active databases.\n\nIntellectual Property:\nYou retain ownership of the content you post on Wayzaway. By posting content, you grant us a worldwide, non-exclusive, royalty-free license \nto use, copy, reproduce, modify, publish, distribute, and display that content.\n\nWayzaway and its logo are trademarks owned by us. You may not use our trademarks without our prior written consent.\n\nThird-Party Links:\nWayzaway may contain links to third-party websites or services. We do not endorse or control these entities and are not responsible for their \ncontent or practices.\n\nChanges to Terms & Conditions:\nWayzaway may update these Terms & Conditions from time to time. We will notify you of significant changes.\n\nYour continued use of Wayzaway after the changes will constitute your acceptance of the revised terms.\n\nContact Us:\nIf you have questions or concerns about these Terms & Conditions, please contact us at contact@wayzaway.com.\n\n\nSubscription\n\nIF YOU SUBSCRIBE TO THE SERVICES FOR A TERM (THE “INITIAL TERM”), THEN THE TERMS WILL BE AUTOMATICALLY RENEWED FOR ADDITIONAL PERIODS OF THE SAME DURATION AS THE INITIAL TERM AT WAYZAWAY’S THEN-CURRENT FEE FOR SUCH SERVICES UNLESS YOU DECLINE TO RENEW YOUR SUBSCRIPTION.\n\n\nFees and Purchase Terms\n\nGeneral Purpose of Terms: Sale of Service, not Software: The purpose of the Terms is for you to secure access to the Services. All fees set forth within and paid by you under the Terms shall be considered solely in furtherance of this purpose. In no way are these fees paid considered payment for the sale, license, or use of WayzAway’s Software, and, furthermore, any use of WayzAway’s Software by you in furtherance of the Terms will be considered merely in support of the purpose of the Terms.\n\nPayment: You agree to pay all fees or charges to your Account in accordance with the fees, charges and billing terms in effect at the time a fee or charge is due and payable. Currently, all payments are made through stripe. If WayzAway offers alternative methods of payment, you may be required to provide WayzAway with a valid credit card (Visa, MasterCard, or any other issuer accepted by us) or PayPal account (“Payment Provider”). Your Payment Provider agreement governs your use of the designated credit card or PayPal account, and you must refer to that agreement and not the Terms to determine your rights and liabilities. By providing WayzAway with your credit card number or PayPal account and associated payment information, you agree that WayzAway is authorized to immediately invoice your Account for all fees and charges due and payable to WayzAway hereunder and that no additional notice or consent is required. You agree to immediately notify WayzAway of any change in your billing address or the credit card or PayPal account used for payment hereunder. WayzAway reserves the right at any time to change its prices and billing methods, either immediately upon posting on WayzAway Properties or by e-mail delivery to you.\n\nService Subscription Fees: You will be responsible for payment of the applicable fee for any Services (each, a “Service Subscription Fee”) at the time you upgrade to a premium or ultimate subscription (each, a “Service Commencement Date”). Except as set forth in the Terms, all fees for the Services are non-refundable. No contract will exist between you and WayzAway for the Services until WayzAway accepts your order by a confirmatory e-mail or other appropriate means of communication.\n\nTaxes: WayzAway’s fees are net of any applicable Sales Tax. If any Services, or payments for any Services, under the Terms are subject to Sales Tax in any jurisdiction and you have not remitted the applicable Sales Tax to WayzAway, you will be responsible for the payment of such Sales Tax and any related penalties or interest to the relevant tax authority, and you will indemnify WayzAway for any liability or expense we may incur in connection with such Sales Taxes. Upon our request, you will provide us with official receipts issued by the appropriate taxing authority, or other such evidence that you have paid all applicable taxes. For purposes of this section, “Sales Tax” shall mean any sales or use tax, and any other tax measured by sales proceeds, that WayzAway is permitted to pass to its customers, that is the functional equivalent of a sales tax where the applicable taxing jurisdiction does not otherwise impose a sales or use tax.\n\nWithholding Taxes: You agree to make all payments of fees to WayzAway free and clear of, and without reduction for, any withholding taxes. Any such taxes imposed on payments of fees to WayzAway will be your sole responsibility, and you will provide WayzAway with official receipts issued by the appropriate taxing authority, or such other evidence as we may reasonably request, to establish that such taxes have been paid.\n\nAutomatic Renewal: Your subscription will continue indefinitely until terminated by us or by you in accordance with the Terms. After your initial subscription period, and again after any subsequent subscription period, your subscription will automatically commence on the first day following the end of such period (each a “Renewal Commencement Date”) and continue for an additional equivalent period, at WayzAway’s then-current price for such subscription. You agree that your Account will be subject to this automatic renewal feature unless you cancel your subscription at any time prior to the Renewal Commencement Date. If you do not wish your Account to renew automatically, or if you want to change or terminate your subscription, please log in and go to the account settings. If you have any issues, you may contact us for further assistance at: contact@wayzaway.com. If you cancel your subscription, you may use your subscription until the end of your then-current subscription term; your subscription will not be renewed after your then-current term expires. However, you will not be eligible for a prorated refund of any portion of the subscription fee paid for the then-current subscription period. By subscribing, you authorize WayzAway to charge your Payment Provider now, and again at the beginning of any subsequent subscription period. Upon renewal of your subscription, if WayzAway does not receive payment from your Payment Provider, (i) you agree to pay all amounts due on your Account upon demand, and/or (ii) you agree that WayzAway may either terminate or suspend your subscription and continue to attempt to charge your Payment Provider until payment is received (upon receipt of payment, your Account will be activated and for purposes of automatic renewal, your new subscription commitment period will begin as of the day payment was received).\n\nAccount deletion is immediate and permanent. If you choose to delete your account, you agree that if the choose to create another account within the previous account’s subscription period, the premium access will not carry through to the new account even if the same credentials as the old account are used to create the new account.\n\nFree Trials and Promotions: We may run promotional offers from time to time on the Website. The terms of any such promotion will be posted on the Website. Unless otherwise indicated, we may establish and modify, in our sole discretion, the terms of such offer and end such offer at any point. If you subscribed during a promotion, used a coupon code, or otherwise received a discount, your Subscription will automatically renew for the full Subscription Fee at the end of the discount period.\n\nDisputes: You must notify us in writing within seven (7) days after receiving your credit card statement, if you dispute any of our charges on that statement or such dispute will be deemed waived. Billing disputes should be notified to the following email address: contact@wayzaway.com.\nIf you do not have a subscription for WayzAway Properties, we may suspend, modify or terminate any of the Services or WayzAway Properties at any time. The Service Subscription Fee for any Service shall be non-refundable. If timely payment cannot be charged to your Payment Provider for any reason, if you have materially breached any provision of the Terms, or if WayzAway is required to do so by law (e.g., where the provision of the Website, the Application, the Software or the Services is, or becomes, unlawful), WayzAway has the right to suspend or terminate any Services provided to you. You agree that all terminations for cause shall be made in WayzAway’s sole discretion and that WayzAway shall not be liable to you or any third party for any termination of your Account.\n\nIndemnification: You agree to indemnify and hold WayzAway, its parents, subsidiaries, affiliates, officers, employees, agents, partners and licensors (collectively, the “WayzAway Parties”) harmless from any losses, costs, liabilities and expenses (including reasonable attorneys’ fees) relating to or arising out of: (a) Your Content; (b) your use of, or inability to use, WayzAway Properties; (c) your violation of the Terms; (d) your violation of any rights of another party, including any Users; or (e) your violation of any applicable laws, rules or regulations. WayzAway reserves the right, at its own cost, to assume the exclusive defense and control of any matter otherwise subject to indemnification by you, in which event you will fully cooperate with WayzAway in asserting any available defenses. You agree that the provisions in this section will survive any termination of your Account, the Terms or your access to WayzAway Properties.\n\n\nTerm and Termination\n\nTerm: The Terms commence on the date when you accept them (as described in the preamble above) and remain in full force and effect while you use WayzAway Properties, unless terminated earlier in accordance with the Terms.\nPrior Use: Notwithstanding the foregoing, if you used WayzAway Properties prior to the date you accepted the Terms, you hereby acknowledge and agree that the Terms commenced on the date you first used WayzAway Properties (whichever is earlier) and will remain in full force and effect while you use WayzAway Properties, unless earlier terminated in accordance with the Terms.\nTermination of Services by WayzAway: \n\nTermination of Services by You: If you want to terminate the Services provided by WayzAway, you may do so by (a) notifying WayzAway at any time and (b) closing your Account for all of the Services that you use. Your notice should be sent, in writing, to: contact@wayzaway.com \nEffect of Termination: Termination of any Service includes removal of access to such Service and barring of further use of the Service. Termination of all Services also includes deletion of your password and all related information, files and Content associated with or inside your Account (or any part thereof), including Your Content. Upon termination of any Service, your right to use such Service will automatically terminate immediately. You understand that any termination of Services may involve deletion of Your Content associated therewith from our live databases. WayzAway will not have any liability whatsoever to you for any suspension or termination, including for deletion of Your Content. All provisions of the Terms which by their nature should survive, shall survive termination of Services, including without limitation, ownership provisions, warranty disclaimers, and limitation of liability.\n\n\nRemedies\n\nViolations: If WayzAway becomes aware of any possible violations by you of the Terms, WayzAway reserves the right to investigate such violations. If, as a result of the investigation, WayzAway believes that criminal activity has occurred, WayzAway reserves the right to refer the matter to, and to cooperate with, any and all applicable legal authorities. WayzAway is entitled, except to the extent prohibited by applicable law, to disclose any information or materials on or in WayzAway Properties, including Your Content, in WayzAway’s possession in connection with your use of WayzAway Properties, to (1) comply with applicable laws, legal process or governmental request; (2) enforce the Terms, (3) respond to any claims that Your Content violates the rights of third parties, (4) respond to your requests for customer service, or (5) protect the rights, property or personal safety of WayzAway, its Users or the public, and all enforcement or other government officials, as WayzAway in its sole discretion believes to be necessary or appropriate. Breach. In the event that WayzAway determines, in its sole discretion, that you have breached any portion of the Terms, or have otherwise demonstrated conduct inappropriate for WayzAway Properties, WayzAway reserves the right to:\n\nWarn you via e-mail (to any e-mail address you have provided to WayzAway) that you have violated the Terms;\n\nDelete any of Your Content provided by you or your agent(s) to WayzAway Properties;\n\nDiscontinue your registration(s) with the any of WayzAway Properties, including any Services or any WayzAway community;\n\nDiscontinue your subscription to any Services;\n\nNotify and/or send Content to and/or fully cooperate with the proper law enforcement authorities for further action; and/or\n\nPursue any other action which WayzAway deems to be appropriate.\n\nNo Subsequent Registration: If your registration(s) with or ability to access WayzAway Properties, or any other WayzAway community is discontinued by WayzAway due to your violation of any portion of the Terms or for conduct otherwise inappropriate for the community, then you agree that you shall not attempt to re-register with or access WayzAway Properties or any WayzAway community through use of a different member name or otherwise, and you acknowledge that you will not be entitled to receive a refund for fees related to those WayzAway Properties to which your access has been terminated. In the event that you violate the immediately preceding sentence, WayzAway reserves the right, in its sole discretion, to immediately take any or all of the actions set forth herein without any notice or warning to you.\n\nInternational Users: WayzAway Properties can be accessed from countries around the world and may contain references to Services and Content that are not available in your country. These references do not imply that WayzAway intends to announce such Services or Content in your country. WayzAway Properties are controlled and offered by WayzAway from its facilities in the United Kingdom. WayzAway makes no representations that WayzAway Properties are appropriate or available for use in other locations. Those who access or use WayzAway Properties from other jurisdictions do so at their own volition and are responsible for compliance with local law.\n\nThank you for choosing Wayzaway. We hope you enjoy using our platform responsibly and respectfully. Your cooperation helps create a positive and safe community for all users."}', 'terms');
INSERT INTO public.pages (id, title, description, name) VALUES (3, 'Privacy Policy', '{"content": "<p class=\"editor-paragraph\">At Wayzaway, we take your privacy seriously and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our platform. By accessing or using Wayzaway, you agree to the practices outlined in this policy.</p><p class=\"editor-paragraph\"><strong>Information We Collect:</strong></p><ul><li><p class=\"editor-paragraph\">Personal Information: During registration, we collect your name, email address, password. We may also collect additional information you choose to provide, such as a profile picture.</p></li><li><p class=\"editor-paragraph\">User-Generated Content: Any content you voluntarily post, including event details, comments, and messages, becomes part of our platform and may be visible to other users.</p></li><li><p class=\"editor-paragraph\">Technical Information: We automatically collect certain technical data, such as your device type, IP address, browser type, and operating system.</p></li><li><p class=\"editor-paragraph\">Cookies: We use cookies to enhance your browsing experience, customize content, and analyse site traffic. You can control cookie preferences through your browser settings. You can at any time change or withdraw your consent from the Cookie Declaration on our website.</p></li></ul><p class=\"editor-paragraph\"><strong>How We Use Your Information:</strong></p><ul><li><p class=\"editor-paragraph\">Account Management: We use your personal information for registration, account authentication, and account recovery purposes.<br>Personalization: We may use your data to help us personalize your Wayzaway experience by recommending events and connecting you with friends.</p></li><li><p class=\"editor-paragraph\">Communication: We may send you service-related communications, such as notifications, updates, and account information. You can control email preferences in your account settings.</p></li><li><p class=\"editor-paragraph\">Public Content: Any content you post, including events and comments, is visible to other users. Exercise caution and avoid sharing sensitive or personal information.</p></li><li><p class=\"editor-paragraph\">Friend Invitations: If you choose to invite friends, we use their email addresses to send invitations on your behalf.</p></li><li><p class=\"editor-paragraph\">Legal Compliance: We may use your information to comply with legal obligations or respond to law enforcement requests.</p></li><li><p class=\"editor-paragraph\">Data Security: We employ industry-standard security measures to protect your data. However, no online platform is entirely secure. Please use common sense when sharing personal information and report any suspicious activity.</p></li><li><p class=\"editor-paragraph\">Third-Party Links: Wayzaway may contain links to third-party websites or services. We are not responsible for the privacy practices of these entities. Review their privacy policies separately.</p></li><li><p class=\"editor-paragraph\">Children''s Privacy: Wayzaway is intended for users aged 13 and over. We do not knowingly collect information from children under 13. If you are a parent or guardian and believe we have collected data from a child under 13, please contact us to have it removed.</p></li><li><p class=\"editor-paragraph\">Account Deletion: You can delete your Wayzaway account at any time. Upon deletion, your data will be removed from our active databases, but residual data may remain in backups and logs for a limited period.</p></li><li><p class=\"editor-paragraph\">Policy Changes: We may update this Privacy Policy to reflect changes in our practices or for legal reasons. We encourage you to review this policy periodically.</p></li></ul><p class=\"editor-paragraph\"><strong>Contact Us</strong>: If you have questions or concerns about our Privacy Policy or data practices, please contact us at contact@wayzaway.com.</p><p class=\"editor-paragraph\">By using Wayzaway, you agree to the terms outlined in this Privacy Policy. Your privacy and trust are essential to us, and we''re here to ensure your Wayzaway experience is secure and enjoyable. Thank you for choosing Wayzaway!</p>"}', 'privacy');
INSERT INTO public.pages (id, title, description, name) VALUES (4, 'About Us', '{"content": "<p class=\"editor-paragraph\"></p>"}', 'about');


--
-- Data for Name: password_reset; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: subscription_plan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subscription_plan (id, title, tagline, price, currency, lookup_key) VALUES (1, 'Ultimate', '* renews every year', 39.95, 'GBP', 'ultimate_yearly');
INSERT INTO public.subscription_plan (id, title, tagline, price, currency, lookup_key) VALUES (2, 'Standard', '* renews every month', 4.95, 'GBP', 'standard_monthly');
INSERT INTO public.subscription_plan (id, title, tagline, price, currency, lookup_key) VALUES (3, 'Basic', '* free lifetime', 0.00, 'GBP', 'basic_free');


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (5, 17, 1, 'sub_1PLAF0RxATCgI2FWqsgt00wY', 0.00, '1970-01-21 03:54:02', '2026-05-28 03:33:58', true, false, '2024-05-28 03:33:59');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (10, 29, 1, 'sub_1PKozsRxATCgI2FWGUUgQoyJ', 39.95, '1970-01-21 03:52:40', '2025-05-27 04:52:56', true, false, '2024-05-27 04:53:01');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (11, 1, 1, 'sub_1PLAGiRxATCgI2FWCGMzOmdt', 0.00, '1970-01-21 03:54:02', '2026-05-28 03:35:44', true, false, '2024-05-28 03:35:46');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (22, 77, 1, 'sub_1PLvYnRxATCgI2FWaJBjNN5U', 0.00, '2024-06-13 09:55:07', '2026-05-30 06:05:33', true, true, '2024-05-30 06:05:34');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (44, 76, 1, 'sub_1PQp56BMhRW3cU8sGzSfdVEo', 0.00, '2024-06-12 15:11:09', '2026-06-12 15:11:08', true, false, '2024-06-12 15:11:09');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (45, 28, 1, 'sub_1PQp6oBMhRW3cU8s2tfznJQl', 0.00, '2024-06-12 15:12:55', '2026-06-12 15:12:54', true, false, '2024-06-12 15:12:55');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (95, 53, 1, 'sub_1PaBO8RxATCgI2FWhn8znZvn', 0.00, '1970-01-20 21:53:41', '2026-07-08 06:49:28', true, false, '2024-07-08 06:49:30');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (98, 188, 1, 'sub_1PbvKGRxATCgI2FWQ1gCW90Y', 0.00, '1970-01-20 22:00:36', '2026-07-13 02:04:40', true, false, '2024-07-13 02:04:42');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (117, 212, 1, 'sub_1QCM6ORxATCgI2FWHRtZHKg9', 0.00, '1970-01-21 00:25:19', '2026-10-21 13:56:56', true, false, '2024-10-21 13:56:58');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (148, 266, 2, 'sub_1Rvl0xRxATCgI2FWkwtTzZ6v', 4.95, '1970-01-21 08:59:46', '2025-11-13 20:11:15', true, false, '2025-08-13 20:11:53');
INSERT INTO public.subscription (id, user_id, plan_id, stripe_subscription_id, subscription_amount, activation_date, expire_date, active, pending_cancel, created_at) VALUES (149, 267, 3, '0', 0.00, '2025-08-24 22:40:34', '2034-12-30 00:00:00', true, false, '2025-08-24 22:40:34');


--
-- Data for Name: user_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (1, true, false, true, '', NULL, 43);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (2, true, false, true, '', NULL, 45);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (3, true, false, true, '', NULL, 50);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (5, true, false, true, '', NULL, 44);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (7, true, false, true, '', NULL, 40);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (8, true, true, true, 'LATEST', NULL, 17);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (9, false, false, false, '', NULL, 29);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (11, false, false, false, '', NULL, 1);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (12, true, false, true, '', NULL, 47);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (13, true, false, true, '', NULL, 38);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (14, true, false, true, '', NULL, 39);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (19, true, false, true, '', NULL, 49);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (20, true, false, true, '', NULL, 46);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (21, true, false, true, '', NULL, 41);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (22, true, false, true, '', NULL, 51);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (23, true, false, true, '', NULL, 28);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (24, true, false, true, '', NULL, 48);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (26, true, false, true, '', NULL, 56);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (27, true, false, true, '', NULL, 57);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (28, true, false, true, '', NULL, 58);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (29, true, false, true, '', NULL, 59);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (30, true, true, true, '', NULL, 60);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (31, true, true, true, '', NULL, 61);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (32, true, true, true, '', NULL, 62);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (33, true, true, true, '', NULL, 63);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (34, true, true, true, '', NULL, 64);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (35, true, true, true, '', NULL, 65);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (36, true, true, true, '', NULL, 66);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (37, true, true, true, '', NULL, 67);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (38, true, true, true, '', NULL, 68);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (39, true, true, true, '', NULL, 69);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (40, true, true, true, '', NULL, 70);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (41, true, true, true, '', NULL, 71);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (42, true, true, true, '', NULL, 72);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (43, true, true, true, '', NULL, 73);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (44, true, true, true, '', NULL, 74);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (45, true, true, true, '', NULL, 75);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (46, true, true, true, '', NULL, 76);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (47, true, true, true, 'LATEST', NULL, 77);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (51, true, true, true, '', NULL, 87);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (52, true, true, true, '', NULL, 88);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (55, true, true, true, '', NULL, 91);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (57, true, true, true, '', NULL, 94);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (59, true, true, true, '', NULL, 96);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (60, true, true, true, '', NULL, 97);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (61, true, true, true, '', NULL, 98);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (62, false, false, true, '', NULL, 99);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (63, true, true, true, '', NULL, 100);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (64, true, true, true, '', NULL, 101);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (65, true, true, true, '', NULL, 102);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (66, true, true, true, '', NULL, 103);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (68, true, true, true, '', NULL, 105);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (69, true, true, true, '', NULL, 106);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (70, true, true, true, '', NULL, 107);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (71, true, true, true, '', NULL, 108);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (72, true, true, true, '', NULL, 109);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (74, true, true, true, '', NULL, 111);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (75, true, true, true, '', NULL, 112);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (76, true, true, true, '', NULL, 113);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (77, true, true, true, '', NULL, 114);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (80, true, true, true, '', NULL, 119);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (85, true, true, true, '', NULL, 124);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (86, true, true, true, '', NULL, 125);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (87, true, true, true, '', NULL, 126);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (88, true, true, true, '', NULL, 127);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (89, true, true, true, '', NULL, 128);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (90, true, true, true, '', NULL, 129);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (91, true, true, true, '', NULL, 130);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (102, true, true, true, 'DESC', NULL, 165);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (106, true, true, true, 'DESC', NULL, 169);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (109, true, true, true, 'DESC', NULL, 172);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (110, true, true, true, 'DESC', NULL, 173);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (118, true, true, true, 'DESC', NULL, 181);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (121, true, true, true, 'DESC', NULL, 184);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (124, true, true, true, 'DESC', NULL, 187);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (125, true, true, true, 'DESC', NULL, 188);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (126, true, true, true, 'DESC', NULL, 189);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (127, true, true, true, 'DESC', NULL, 190);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (128, true, true, true, 'DESC', NULL, 191);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (129, true, true, true, 'DESC', NULL, 192);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (130, true, true, true, 'DESC', NULL, 193);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (131, true, true, true, 'DESC', NULL, 194);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (132, true, true, true, 'DESC', NULL, 195);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (133, true, true, true, 'DESC', NULL, 196);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (134, true, true, true, 'DESC', NULL, 197);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (135, true, true, true, 'DESC', NULL, 198);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (136, true, true, true, 'DESC', NULL, 199);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (137, true, true, true, 'DESC', NULL, 200);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (138, true, true, true, 'DESC', NULL, 201);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (139, true, true, true, 'DESC', NULL, 202);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (141, true, true, true, 'DESC', NULL, 204);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (142, true, true, true, 'DESC', NULL, 205);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (143, true, true, true, 'DESC', NULL, 206);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (144, true, true, true, 'DESC', NULL, 207);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (145, false, false, false, 'DESC', NULL, 208);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (146, true, true, true, 'DESC', NULL, 209);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (147, true, true, true, 'DESC', NULL, 210);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (148, true, true, true, 'DESC', NULL, 211);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (149, true, true, true, 'DESC', NULL, 212);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (150, true, true, true, 'DESC', NULL, 213);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (151, true, true, true, 'DESC', NULL, 214);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (152, true, true, true, 'DESC', NULL, 215);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (153, true, true, true, 'DESC', NULL, 216);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (154, true, true, true, 'DESC', NULL, 217);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (155, true, true, true, 'DESC', NULL, 218);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (156, true, true, true, 'DESC', NULL, 219);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (157, true, true, true, 'DESC', NULL, 220);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (159, true, true, true, 'DESC', NULL, 222);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (160, true, true, true, 'DESC', NULL, 223);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (161, true, true, true, 'DESC', NULL, 224);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (162, true, true, true, 'DESC', NULL, 225);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (163, true, true, true, 'DESC', NULL, 226);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (164, true, true, true, 'DESC', NULL, 227);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (165, true, true, true, 'DESC', NULL, 228);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (166, true, true, true, 'DESC', NULL, 229);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (167, true, true, true, 'LATEST', NULL, 230);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (168, true, true, true, 'DESC', NULL, 231);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (169, true, true, true, 'DESC', NULL, 232);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (170, true, true, true, 'DESC', NULL, 233);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (171, true, true, true, 'DESC', NULL, 234);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (172, true, true, true, 'DESC', NULL, 235);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (173, true, true, true, 'DESC', NULL, 236);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (174, true, true, true, 'DESC', NULL, 237);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (175, true, true, true, 'DESC', NULL, 238);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (176, true, true, true, 'DESC', NULL, 239);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (178, true, true, true, 'DESC', NULL, 241);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (179, true, true, true, 'DESC', NULL, 242);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (180, true, true, true, 'DESC', NULL, 243);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (181, true, true, true, 'DESC', NULL, 244);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (182, true, true, true, 'DESC', NULL, 245);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (184, true, true, true, 'DESC', NULL, 247);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (185, true, true, true, 'DESC', NULL, 248);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (186, true, true, true, 'DESC', NULL, 249);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (187, true, true, true, 'DESC', NULL, 250);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (188, true, true, true, 'DESC', NULL, 251);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (189, true, true, true, 'DESC', NULL, 252);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (190, true, true, true, 'DESC', NULL, 253);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (191, true, true, true, 'DESC', NULL, 254);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (193, true, true, true, 'DESC', NULL, 256);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (195, true, true, true, 'DESC', NULL, 258);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (197, true, true, true, 'DESC', NULL, 260);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (199, true, true, true, 'DESC', NULL, 262);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (200, true, true, true, 'DESC', NULL, 263);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (201, true, true, true, 'DESC', NULL, 264);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (202, true, true, true, 'DESC', NULL, 265);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (203, true, true, true, 'DESC', NULL, 266);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (204, true, true, true, 'DESC', NULL, 267);
INSERT INTO public.user_settings (id, email_new_event_notification, email_update_event_notification, email_new_comment_notification, sort, theme, user_id) VALUES (18, true, true, true, 'ASC', 'dark', 53);


--
-- Name: blog_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blog_post_id_seq', 1, false);


--
-- Name: comment_mention_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_mention_id_seq', 1, false);


--
-- Name: event_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_category_id_seq', 1, false);


--
-- Name: event_collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_collection_id_seq', 1, true);


--
-- Name: event_collection_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_collection_item_id_seq', 1, true);


--
-- Name: event_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_comment_id_seq', 1, true);


--
-- Name: event_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_group_id_seq', 1, true);


--
-- Name: event_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_post_id_seq', 1, false);


--
-- Name: event_reaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_reaction_id_seq', 1, true);


--
-- Name: event_wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_wishlist_id_seq', 1, false);


--
-- Name: friendship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friendship_id_seq', 1, false);


--
-- Name: group_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_member_id_seq', 1, true);


--
-- Name: invitation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invitation_id_seq', 1, false);


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pages_id_seq', 4, true);


--
-- Name: password_reset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.password_reset_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_id_seq', 1, false);


--
-- Name: subscription_plan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_plan_id_seq', 1, false);


--
-- Name: user_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_group_id_seq', 1, true);


--
-- Name: user_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_settings_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

\unrestrict Gkxh7ffdjGj9RDRWP2iwsyBIZfOOVtvjzVYfgMebasefv2OXuxl5pKkwNPKzduU

