// ignore_for_file: file_names, unused_import, use_build_context_synchronously, unnecessary_brace_in_string_interps, avoid_print
// import 'package:eosdart/eosdart.dart' as eos;
// import 'package:flutter/material.dart' hide Action;

import 'dart:convert';
import 'dart:io';
import 'dart:io' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riise/providers/FirebaseProvider.dart';
import 'package:riise/screens/Faculty/FacultyDetailScreen.dart';

import '../models/SpeakerInfo.dart';
import "../models/FacultyInfo.dart";

class FacultiesProvider with ChangeNotifier {
  static const dataList = [
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'A V Subramanyam',
      'faculty_EmailId': 'subramanyam@iiitd.ac.in',
      'faculty_Department': 'ECE, CSE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': 'Infosys Centre for Artificial Intelligence (CAI), Visual Conception Group',
      'faculty_Authorization': 'True',
      'faculty_Bio': 'I completed my Ph.D. at Nanyang Technological University, Singapore and undergraduate studies at Indian School of Mines University, Dhanbad, India. I work in the area of Multimedia and Vision, Image Processing and, Machine Learning. In particular, I am working on problems in fine-grained object recognition with applications to object re-identification and visual tracking, adversarial attacks, and cross modal recognition. I am a recipient of the Early Career Research Award, Department of Science and Technology. Our research group – Visual Conception Group maintains an active collaboration with leading institutes like NUS Singapore, QUT Australia, NII Japan, and UiT Norway.',
      'faculty_College': 'PhD (2012), Nanyang Technological University, Singapore',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/images/faculty/subramanyam.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/subramanyam',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907437"',
      'faculty_Office_Address': 'B-604 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': 'Multimedia and Vision,Machine Learning',
      'faculty_Teaching_Interests': 'Statistical Machine Learning,Digital Image Processing, Digital Signal Processing, Signals and Systems, Multimedia Security',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/ZCg5',
      'faculty_Website_Page': '/subramanyam',
      'faculty_QR_Code_Image_Url': 'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsubramanyam%40iiitd.ac.in%2FZCg5.png?alt=media&token=62e9e87a-2b58-40fb-acd8-20b0536ebb50',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Aasim Khan',
      'faculty_EmailId': 'aasim@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Dr. Aasim Khan is Assistant Professor at the Department of Social Sciences and Humanities, IIIT-Delhi. Aasim is a specialist in global and area studies, with a focus on South Asia. His research interests combine his training in communication, political theory and public policy, and he is particularly interested in studying the expansion of the Internet in the global South. He was educated in Delhi (St Stephen’s College and MCRC, Jamia Millia Islamia) and London (SOAS and King's College London) and completed his PhD in Politics and Public Policy, from King's College London, in 2018. Most recently, Aasim was awarded the Fulbright-Nehru postdoctoral fellowship and he will be spending a year as a Visiting Scholar in Political Science at the Watson Institute, Brown University (beginning Fall 2022).Over the years, his research and reporting has been supported by several grants and fellowships. He received the Global Institutes Studentships and the Mazumdar Fellowship (2012-2015) at the King's India Institute. In 2014, he was awarded the Global Governance Futures fellowship by the GPPi Institute (Berlin). Aasim was a visiting faculty at IIM-Indore (2019) and appointed an Associate Researcher at the Centre de Sciences Humaines (CSH, UMIFRE n°20) in September 2021. Aasim has also raised several grants to fund his work, including the IMPRESS grant by the Indian Council for Social Science Research (ICSSR), and a Global Challenges Research Fund GCRF grant (in collaboration with the Goldsmiths, UK). As a journalist he received a mid-career fellowship to report on caste and access to healthcare by PANOS South Asia (article based on the fieldwork appeared in an anthology published Penguin/Zubaan, 2012). He was also a recipient of a research stipendship for research on urban migration and markets, by the SARAI program of CSDS, Delhi.His research and commentaries have been published in several peer-reviewed journals including Culture Unbound, Global Policy, Television and New Media, India Review and contributed to several edited volumes. These include a chapter in a volume on politics of digital infrastructure in urban India titled Diginaka (Orient Blackswan, 2020). More recently, he's developed a theory of 'data states' in the global South and has contributed a chapter on it for a volume on Transforming India (forthcoming World Scientific, 2023). Another strand of this research relates the role of digital mediation in climate action and he published on the 'Climate Strikes in Millennial India' in Communication, Culture and Critique (OUP, 2022). Aasim co-edited a special issue on digital politics in 'Millennial India' (Sage, 2019) and is currently co-editing another volume on Twitter and politics in India (forthcoming in Global Policy, 2023).Aasim has delivered more than 20 public lectures in the last few years on themes related to his research and writing. Some preeminent instances include the 'Extreme Speech' workshop held at India Habitat Centre, Delhi, public seminar at the Center for Law and Governance, JNU, and an introduction to Critical Thinking in Social Sciences at the Department of Humanities and Social Sciences, IIT-Jodhpur and at the Data, State and Society seminar series at TISS (February 2020). Aasim was an invited speaker on Data, Society and Culture at the 10th anniversary event of King's India Institute held in Delhi, 2022 and at the seminar on journalism and society at Goldsmiths University (London, 2023). Before moving to academia Aasim worked for many years in broadcast news journalism (CNN-IBN) and international development (Oxfam GB) and continues to write for popular news outlets, including Scroll.com, and is a regular contributor to The Book Review.",
      'faculty_College': "PhD (2018), King's College London",
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/aasim_0.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/aasim',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907463"',
      'faculty_Office_Address': 'B-202 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Digital Politics,Data and Governance,Social and Climate Movements,Civic Media and Journalism',
      'faculty_Teaching_Interests':
          'Digital Politics,Democracy and News,Data and Society,Critical Thinking ',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/aasim',
      'faculty_Website_Page': '/aasim',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Faasim%40iiitd.ac.in%2Faasim.png?alt=media&token=92b417fe-265e-4ede-b17d-93770140de86',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Abhijit Mitra',
      'faculty_EmailId': 'abhijit@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Abhijit Mitra received his Ph.D. from the Indian Institute of Technology Delhi (2017) under the funding of the British Telecom Fellowship. His experience has been in modeling and network planning for metro and core optical networks. He has been a reviewer in reputed journals like the Journal of Optical Communication and Networking (JOCN), and the Journal of Lightwave Technology (JLT). He has published in major venues like Proceedings of the IEEE, JOCN, JLT, Optical Fiber Communications (OFC) Conference, and the European Conference on Optical Communications (ECOC) with due industry-academic collaborations. Further, he has led funded projects by DST, MIETY, and DRDO in the capacity of PI/Co-PI and functioning as a collaborator in a project funded by the National Science Foundation (NSF), USA. He has been awarded DST Inspire Faculty Fellowship (2017-2022) by DST, British Council (Alumni Awards): Professional Achievement Awards (2019) by British Council, the prestigious Fulbright Post Doctoral Research Fellowship by the United States India Education Foundation (USIEF) and Sparkle-Marie Skłodowska-Curie Actions (MSCA) Cofund Fellowship (2022, not availed). Overall he has 10 years of research experience in Transport Optical Networks.',
      'faculty_College': 'PhD (2017), IIT Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/abhijit_0.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/abhijit2/',
      'faculty_Website_Url': 'https://iiitd.ac.in/abhijit',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907542"',
      'faculty_Office_Address': 'A-207 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Multi-band Optical Networks,Space Division Multiplexing,Quantum Key Distribution',
      'faculty_Teaching_Interests':
          'Digital Communication Systems,Next Generation Optical Networks',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/abhijit',
      'faculty_Website_Page': '/abhijit',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fabhijit%40iiitd.ac.in%2Fabhijit.png?alt=media&token=1459d597-ecee-4d71-9f6d-e8e9bed914d9',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Aman Parnami',
      'faculty_EmailId': 'aman@iiitd.ac.in',
      'faculty_Department': 'HCD',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Aman Parnami recently received a PhD in Human-Computer Interaction with a minor in Industrial Design from the Georgia Institute of Technology. Prior to that, he has completed a Masters in HCI from the same institute and a dual degree in CSE from IIT Bombay. He had interned with Microsoft Research in Redmond and Intel in Hillsboro. His research interests include the development of rapid prototyping tools for novel wearable interactions and devices. Furthermore, he is passionately involved in the design of constructionist learning environments for CS courses. Besides academics, Aman regularly trains for the marathon and enjoys hiking as well as biking.',
      'faculty_College': 'PhD (2017), Georgia Institute of Technology',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/amanparnami.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/aman',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907521"',
      'faculty_Office_Address': 'A-405 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Wearable Computing,Design Research,Education Technology',
      'faculty_Teaching_Interests':
          'Maker-Oriented Learning,HCI,Wearable Computing, Interactive Product Design',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/naxz',
      'faculty_Website_Page': '/aman',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Faman%40iiitd.ac.in%2Fnaxz.png?alt=media&token=1ac1e407-4600-4b2b-83e9-f92895797130',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Anand Srivastava',
      'faculty_EmailId': 'anand@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Anand Srivastava did his M.Tech. and Ph.D. from IIT Delhi and is currently working in IIIT Delhi as Professor in ECE department since Nov. 2014 and also Director in IIIT Delhi Incubation Center. I am also Adjunct faculty in Bharti School of Telecom Technology at IIT Delhi. Before joining IIIT Delhi, I was Dean & Professor in School of Computing and Electrical Engineering at Indian Institute of Technology Mandi, HP, India from Jan. 2012 to Nov. 2014. Prior to this, I was with Alcatel-Lucent-Bell Labs, India as solution architect for access and core networks for 2.5 years. My initial stint (∼ 20 years) was with Center for Development of Telematics (CDOT), a telecom research center of Govt. of India where I was Director and member of CDOT Board. During my stay in CDOT, I provided technical leadership and motivation to team of engineers engaged in the development of national level projects in the areas of Telecom Security Systems, Network Management System, Intelligent Networks, Operations Support Systems, Access Networks (GPON) and Optical Technology based products. Majority of these projects were completed successfully and commercially deployed in the public telecom network. I also carried out significant research work in the Photonics Research Lab, Nice, France, under the Indo-French Science & Technology Cooperation Program on “Special optical fibers and fiber-based components for optical communications” during 2007-2010 in different phases. I was also closely involved with ITU-T, Geneva in Study Group 15 and represented India for various optical networking standards meetings. Currently, I am driving VLC/LiFi standardization activities under the aegis of TSDSI. My research work is in the area of optical core & access networks, Vehicle-to-vehicle communications, Fiber-Wireless (FiWi) architectures, and Visible light communications.',
      'faculty_College': 'PhD (2003), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/anand_1.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/anand',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907450"',
      'faculty_Office_Address': 'A-605 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Digital Communications,Wireless and Optical communications,Optical Networks',
      'faculty_Teaching_Interests':
          'Digital, Optical and Wireless Communication',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/anand',
      'faculty_Website_Page': '/anand',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fanand%40iiitd.ac.in%2Fanand.png?alt=media&token=87454975-267b-4dd4-bb54-288d51a9aac6',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Angshul Majumdar',
      'faculty_EmailId': 'angshul@iiitd.ac.in',
      'faculty_Department': 'ECE, CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Angshul Majumdar is a Professor at Indraprastha Institute of Information Technology, Delhi. He completed his Ph.D. from the University of British Columbia in 2012; he finished his thesis in a record time of less than two years. His research interests are in algorithms and applications of sparse signal recovery and low rank matrix recovery. Specifically, Angshul is interested in problems in biomedical signal processing and imaging. Angshul has written over 70 journal and conference papers since the inception of his research career in 2007. He has recently written a book on Compressed Sensing based MRI Reconstruction which is in print at Cambridge University Press.',
      'faculty_College': 'PhD (2012), University of British Columbia, Canada',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/angshul.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/angshul',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907451"',
      'faculty_Office_Address': 'A-606 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Sparse Recovery,Low-rank matrix completion,Medical Imaging,Biomedical Signal Processing,Hyper-spectral Imaging,Collaborative Filtering',
      'faculty_Teaching_Interests': 'Image Processing,Collaborative Filtering',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/angshul',
      'faculty_Website_Page': '/angshul',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fangshul%40iiitd.ac.in%2Fangshul.png?alt=media&token=aea6b0f4-d343-4eeb-b8db-8b3fc53d718f',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Anmol Srivastava',
      'faculty_EmailId': 'anmol@iiitd.ac.in',
      'faculty_Department': 'HCD',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Anmol Srivastava specializes in Human-Computer Interaction. In 2019, he received his Ph.D. from India's pioneering UE and HCI Lab at IIT Guwahati. Anmol explores emerging technologies' potential to facilitate utility, usability, and creative self-expression in various contexts and use cases. His research output has received several awards at the national and international levels. Before joining IIITD, he headed the UX & Interaction Design Program and the XR & IxD Lab at the School of Design, UPES (Dehradun). His current research focuses on AR/VR, the Metaverse, and Tangible User Interfaces. Besides being passionate about Design Education, he is also a strong proponent of maker culture.",
      'faculty_College': 'PhD (2019), IIT Guwahati',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/anmol.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/anmols/',
      'faculty_Website_Url': 'https://iiitd.ac.in/anmol',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907467"',
      'faculty_Office_Address': 'A-404 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'AR/VR,The Metaverse,Tangible User Interfaces',
      'faculty_Teaching_Interests':
          'AR/VR,The Metaverse,Tangible User Interfaces',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/anmol',
      'faculty_Website_Page': '/anmol',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fanmol%40iiitd.ac.in%2Fanmol.png?alt=media&token=b91ba378-0036-40a1-a40d-45cc1cd4c16c',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Anubha Gupta',
      'faculty_EmailId': 'anubha@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Member-Infosys Centre for Artificial Intelligence (CAI),Core Member-Center of Excellence in Healthcare, IIIT-Delhi,SBILab, Deptt. of ECE, IIIT-Delhi',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Prof. Anubha Gupta graduated with a Ph.D. degree in Electrical Engineering from IIT Delhi in 2006. She did her bachelor's and master's in ECE from Delhi University in 1991 and 1997, respectively. She started her professional career with the position of Assistant Director at ALL India Radio (through Indian Engineering Services) in 1993 and worked there until Feb. 1999. In Feb. 1999, she joined Netaji Subhas Institute of Technology (NSIT), Dwarka, Delhi. She worked as Assistant Professor in the Computer Engineering Department at NSIT for eight years. From July 2011 to Dec. 2013, she worked as associate professor at IIIT Hyderabad. In Dec 2013, she joined IIIT Delhi, where she is currently working as a Professor in the Department of Electronics and Communication Engineering.Apart from her engineering interests, Dr. Gupta is deeply interested in education policy issues. She did her second master's as a full time student from University of Maryland College Park, USA from 2008 to 2010. During this time, she worked as a project manager on a state policy related education project at the University System of Maryland, USA. On graduation, she worked as Director of Assessment at the Bowie State University, Maryland USA from Oct. 2010 to April 2011.She has authored/co-authored more than 100 technical papers in scientific journals and conferences. She has published research papers in both engineering and education. Her research interests include biomedical signal and image processing including fMRI, MRI, EEG, ECG signal processing, genomics signal processing in cancer research, Wavelets in deep learning, signal processing for communication engineering, and engineering education. Prof. Gupta is a recipient of SERB POWER Fellowship, 2021. She is a senior member of IEEE Signal processing Society and a member of IEEE Women in Engineering Society. She is an Associate Editor of IEEE Access journal, Associate Editor of IEEE Signal Processing Magazine eNewsletter, and Associate Editor, Frontiers in Neuroscience Methods. She is the technical committee member of BISP, IEEE Signal Processing Society for the term 1/1/2022 to 12/31/2024.",
      'faculty_College': 'PhD (2006), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/anubhag.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/anubha',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907428"',
      'faculty_Office_Address': 'B-609 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Applications of Wavelet Transforms,Machine (Deep) Learning and Compressed Sensing,Sparse Reconstruction, FMRI/EEG/MRI/DTI Signal and Image Processing ,Genomics Signal Processing ,Signal Processing for Communication Engineering,and RF Energy Harvesting',
      'faculty_Teaching_Interests':
          'Courses related to signal and image processing,Wavelet and Multirate Analysis,Statistical Signal Processing',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/anubha',
      'faculty_Website_Page': '/anubha',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fanubha%40iiitd.ac.in%2Fanubha.png?alt=media&token=08a9703a-dc14-4e56-963c-0b075b9de0a6',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Anuj Grover',
      'faculty_EmailId': 'anuj@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Anuj Grover has obtained Ph.D. from IIT Delhi in 2015, MS (Electronic Circuits and Systems) from UCSD in 2003, and B Tech (EE) from IIT Delhi in 2000. Prior to joining IIIT-Delhi, he had been working as Principal Engineer - Member of Technical Staff at STMicroelectronics, Greater NOIDA. He has been associated with IIIT-Delhi as a Guest Faculty since January 2018. In more than 18 years of experience in the semiconductor industry as a Memory Designer, he has worked on a wide range of technologies like Bulk CMOS, BCD, Imaging, UTBB-FDSOI CMOS, e-NVM across a range of feature sizes from 22nm to 0.35um. He has more than 25 publications across IEEE journals and conferences.He has strong interest in Systematic Innovation and is trained on applying Theory of Inventive Problem Solving (TRIZ). He has been awarded TRIZ Level-3 Certification from MIT and MATRIZ. He has also been certified by World Intellectual Property Organization (WIPO) on application of TRIZ for patents. He has been a STUniversity certified trainer on a program "From Creativity to Innovation". He has 5 granted patents and more than 10 patent applications in different stages of filing.His current research interests include Ultra Low Power In-Memory Compute for edge computing and machine learning applications; safety and security in hardware; and error resilient energy efficient systems.\nHe is also a Franklin Covey certified trainer for 7 Habits of Highly Effective People Signature Program and would be keen to bring this program to IIIT-D for faculty, staff and students.',
      'faculty_College': 'PhD (2015), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/anujg_0.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/anujgrover/',
      'faculty_Website_Url': 'https://iiitd.ac.in/anujg',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907494"',
      'faculty_Office_Address': 'A-610 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Ultra Low Power In-Memory Compute for edge computing and machine learning applications, Safety and security in hardware; and Error resilient energy efficient systems',
      'faculty_Teaching_Interests':
          'Memory Design,VLSI Design, Solid State Devices, Theory of Inventive Problem Solving\n\n',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/anujg',
      'faculty_Website_Page': '/anujg',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fanuj%40iiitd.ac.in%2Fanujg.png?alt=media&token=dd51e395-0282-4a97-a6e0-7590d6bef4b0',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Anuradha Sharma',
      'faculty_EmailId': 'anuradha@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Anuradha Sharma is a Professor in the Department of Mathematics at IIIT-Delhi. She received B.Sc. degree with Honours in Mathematics, and M.Sc. and Ph.D. degrees in Mathematics from Centre for Advanced Study in Mathematics, Panjab University, Chandigarh, India, in 2000, 2002, and 2006, respectively. She was awarded a University Gold Medal for standing first in M.Sc. Prior to joining IIIT Delhi, she has worked as an Assistant Professor in the Department of Mathematics at IIT Delhi for around five and a half years and as an Assistant Professor in the Centre for Advanced Study in Mathematics, Panjab University, Chandigarh for around three years. At IIT-Delhi, she received the Kusuma Outstanding Young Faculty Fellowship. She works in Algebraic Coding Theory. Her other research interests include Number Theory and Algebra. She has around 40 research publications in reputed international venues including but not limited to Finite Fields and Applications, Discrete Mathematics, IEEE Transactions on Information Theory, etc. She has also published a book titled "Codes and Modular Forms: A Dictionary" jointly with Minjia Shi, YoungJu Choie and Patrick Solé. Her Erdős number is 3',
      'faculty_College': 'PhD (2006), Panjab University, Chandigarh, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/anuradhas.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/090380/',
      'faculty_Website_Url': 'https://iiitd.ac.in/anuradha',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907534"',
      'faculty_Office_Address': 'B-311 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Algebraic Coding Theory, Number Theory and Algebra',
      'faculty_Teaching_Interests':
          'Algebraic Coding Theory, Number Theory,Algebra, Quantum error-correction ,DNA error-correction',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/anuradha',
      'faculty_Website_Page': '/anuradha',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fanuradha%40iiitd.ac.in%2Fanuradha.png?alt=media&token=6cf1b965-d0c9-4ac1-ad6b-42c32c1e6f26',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Arani Bhattacharya',
      'faculty_EmailId': 'arani@iiitd.ac.in',
      'faculty_Department': 'CSE,ECE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Arani Bhattacharya earned his Ph.D. degree holder from Stony Brook University in Computer Science in 2019. His research experience is in the general areas of wireless networks, with a focus on applying algorithms, formal verification, and machine learning to different emerging applications. He has co-authored over 20 publications in different reputed venues. Before joining IIIT-Delhi, Arani has worked as a postdoctoral researcher at KTH Royal Institute of Technology, Stockholm and as a research intern at IMDEA Networks Institute, Madrid. He regularly serves as a reviewer for several top-tier journals such as IEEE/ ACM Transactions on Networking, IEEE Transactions on Wireless Communications and IEEE Transactions on Mobile Computing.',
      'faculty_College': 'PhD (2019), Stony Brook University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/arani.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/arani-bhattacharya-7a6a4a69/',
      'faculty_Website_Url': 'https://iiitd.ac.in/arani',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907434"',
      'faculty_Office_Address': 'B-510 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Low latency compute and machine learning services, Video streaming and physical layer of wireless networks',
      'faculty_Teaching_Interests':
          'Statistical Machine Learning, Deep Learning,Digital Image Processing',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/arani',
      'faculty_Website_Page': '/arani',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Farani%40iiitd.ac.in%2Farani.png?alt=media&token=4e326126-6a94-4ec6-8cf9-bf3f3d037241',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Arjun Ray',
      'faculty_EmailId': 'arjun@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Arjun Ray is a computational structural biologist and earned his Ph.D. degree from CSIR-IGIB. His formal education in the field of chemistry and biophysics led him to be interested in understanding how biological processes are carried out by three-dimensional interactions. His previous researches include developing methods and tools in the field of structure prediction and force distributed analysis of lipids, deciphering mechanistic understanding of interactions between various biological molecules and working with multi-scale systems. As a structural biologist, he has been regularly working with techniques for structure prediction, molecular dynamics simulations and biomolecular docking. Along with his research endeavours, he has held several positions such former President of Regional Student Group (India) for the International Society for Computational Biology.',
      'faculty_College': 'Ph.D. CSIR-IGIB',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/arjunr.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/arjunray/',
      'faculty_Website_Url': 'https://iiitd.ac.in/arjun',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907438"',
      'faculty_Office_Address': 'A-310 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Deciphering the mechanism of CRISPR-Cas9, Elucidating molecular interactions in the reverse cholesterol pathway, Structural genomic problems',
      'faculty_Teaching_Interests':
          'Biophysics, Computer-aided Drug Design, Protein biology',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/arjun',
      'faculty_Website_Page': '/arjun',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Farjun%40iiitd.ac.in%2Farjun.png?alt=media&token=ab6d2eeb-4534-4c1f-b0ad-ff40d8ab0096',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Arun Balaji Buduru',
      'faculty_EmailId': 'arunb@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Arun Balaji Buduru is an assistant professor at Indraprastha Institute of Information Technology, Delhi. He received his Ph.D. in Computer Science, specializing in Information Assurance, at Arizona State University in 2016. His research interests include cyber security, reinforcement learning and stochastic planning. He received his B.E. degree in Computer Science in 2011 from Anna University at Chennai, India. He has worked as a research intern as part of Cisco IoT Architecture Group. His current research focuses on adaptive user re-authentication on touch-based devices, predicting security breaches in critical cyber infrastructures, and user behavior based adaptive IoT device reconfiguration',
      'faculty_College': 'PhD (2016), Arizona State University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/arunb.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/arunb',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907469"',
      'faculty_Office_Address': 'B-504 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Cyber security,Reinforcement learning and stochastic planning',
      'faculty_Teaching_Interests':
          'Computer Security Privacy and User Behavioral Modeling',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/arunb',
      'faculty_Website_Page': '/arunb',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Farunb%40iiitd.ac.in%2Farunb.png?alt=media&token=b4e89627-4f17-49f1-b87f-74985d384943',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Ashish Kumar Pandey',
      'faculty_EmailId': 'ashish.pandey@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'He obtained his Ph.D. in Mathematics from the University of Illinois at Urbana-Champaign, USA in April 2018. He completed his Integrated M.Sc. in Mathematics from National Institute of Science Education and Research (NISER), Bhubaneswar, India in May 2012. His primary area of research is Partial Differential Equations (PDEs). He tries to understand existence, well-posedness, stability or instability of solutions of nonlinear PDEs arising as physical models. He uses tools from Harmonic analysis and Operator theory.',
      'faculty_College':
          'Ph.D. (2018), University of Illinois at Urbana-Champaign, USA.',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/ashishpandey.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/ashishk',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907461"',
      'faculty_Office_Address': 'B-307 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': 'Partial Differential Equations (PDEs)',
      'faculty_Teaching_Interests':
          'Stability or instability of solutions of nonlinear PDEs arising as physical models',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/ashishk',
      'faculty_Website_Page': '/ashishk',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fashish.pandey%40iiitd.ac.in%2Fashishk.png?alt=media&token=271e423c-f5f8-483e-865f-0953629faaaa',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Bapi Chatterjee',
      'faculty_EmailId': 'bapi@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Before joining IIIT-Delhi, Dr. Chatterjee worked as an ISTPlus Postdoc Fellow at the Institute of Science and Technology Austria for two and a half years. Prior to that, he worked as a Researcher with IBM India Research Lab for two years post his doctoral studies. Dr. Chatterjee obtained a Ph.D. in Computer Science and Engineering from Chalmers University of Technology, Gothenburg, Sweden in January 2018. His current research interests are Distributed Machine Learning, Concurrent Data Structures, Neural Architecture Search, and Learned Index Structures.',
      'faculty_College':
          'PhD (2018), Chalmers University of Technology, Sweden',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/bapi.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/bapichatterjee/',
      'faculty_Website_Url': 'https://iiitd.ac.in/bapi',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907371"',
      'faculty_Office_Address': 'B-408 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Distributed Machine Learning,Concurrent Data Structures,Neural Architecture Search,Learned Index Structures',
      'faculty_Teaching_Interests':
          'Data Structures,Parallel/Distributed/High-performance Computing,Machine Learning,Optimization and related subjects',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/bapi',
      'faculty_Website_Page': '/bapi',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fbapi%40iiitd.ac.in%2Fbapi.png?alt=media&token=28ee84f6-732d-4129-a9b7-1da031a2e6a2',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Chanekar Prasad Vilas',
      'faculty_EmailId': 'prasad@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Chanekar Prasad Vilas received his undergraduate degree in Mathematics and Computing from the Indian Institute of Technology, Kharagpur, India and an AMIE degree in Mechanical Engineering from the Institution of Engineers, India. He then obtained M.Sc. and Ph.D. degrees in Mechanical Engineering from the Indian Institute of Science, Bangalore, India and the University of Maryland, College Park, USA respectively. He was a Post-Doctoral researcher in the Department of Mechanical and Aerospace Engineering at the University of California, San Diego, USA.',
      'faculty_College': 'PhD (2018), University of Maryland, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/chanekar.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/chanekar',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907374"',
      'faculty_Office_Address': 'B-610 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Kinematics,Dynamics,Control and optimization of large-scale engineering systems with applications to system co-design, Robotics, Renewable Energy Systems, Power Networks, Neuroscience',
      'faculty_Teaching_Interests':
          'Optimal control,Nonlinear control,Robotics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/chanekar',
      'faculty_Website_Page': '/chanekar',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fprasad%40iiitd.ac.in%2Fchanekar.png?alt=media&token=c5442a66-6cdc-4971-abd0-bbb7adb83f84',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Debajyoti Bera',
      'faculty_EmailId': 'dbera@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Associate Head ,Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Debajyoti Bera is currently an Associate Professor in IIIT-Delhi. He received Ph.D. in Computer Science from Boston University in 2010, and B.Tech. in Computer Sc. and Engg. from IIT-Kanpur in 2002. He is currently involved in active research on topics in quantum complexity, graph algorithms and privacy issues in online services. His usual areas of research interest spans quantum computing, algorithms, theoretical aspects of security and privacy and algorithmic challenges in other domains like database, networking, etc. Apart from theoretical computer science, he is also interested in open-source development and computer systems. When not engaged in academic thoughts, he prefers to indulge in photography, music or reading.',
      'faculty_College': 'PhD (2009), Boston University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/debajyoti.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/debajyoti-bera-304112229/',
      'faculty_Website_Url': 'https://iiitd.ac.in/dbera',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907442"',
      'faculty_Office_Address': 'B-508 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Algorithms,Complexity Theory,Quantum Computing',
      'faculty_Teaching_Interests':
          'Algorithms,Complexity Theory,Quantum Computing',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/dbera',
      'faculty_Website_Page': '/dbera',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fdbera%40iiitd.ac.in%2Fdbera.png?alt=media&token=ec185481-d813-475d-9625-e68b0d21d7ca',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Debarka Sengupta',
      'faculty_EmailId': 'debarka@iiitd.ac.in',
      'faculty_Department': 'CSE,CB',
      'faculty_Position': 'Associate Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Infosys Centre for Artificial Intelligence,Centre for Computational Biology',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Debarka is an Associate Professor of Computational Biology and Computer Science at IIIT-Delhi. He is also an honorary Associate Professor at the Queensland University of Technology-Brisbane. Debarka carried out his doctoral and post-doctoral research in the Machine Intelligence Unit of the Indian Statistical Institute and Genome Institute of Singapore, respectively. His group has been among the first to introduce big data algorithms in the field of single-cell genomics. He received INSPIRE faculty Award in 2015 by the Government of India. His lab invented and commercialized a panel of eleven platelet genes to track the early onset of cancer. ',
      'faculty_College': 'PhD, Jadavpur University, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/debarka.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/debarka-sengupta-3607517/',
      'faculty_Website_Url': 'https://iiitd.ac.in/debarka',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907446"',
      'faculty_Office_Address': 'A-306 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Computational Genomics, Machine Learning, Bioinformatics',
      'faculty_Teaching_Interests':
          'Algorithms, statistics, machine learning, computational biology',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/debarka',
      'faculty_Website_Page': '/debarka',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fdebarka%40iiitd.ac.in%2Fdebarka.png?alt=media&token=65a060f4-7912-4322-8371-98931e00f763',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Debika Banerjee',
      'faculty_EmailId': 'debika@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Debika Banerjee obtained Ph.D. in Mathematics from Harish-Chandra Research Institute, Allahabad in 2017 and M.Sc. in Mathematics from IIT Kanpur in 2011. Prior to joining IIIT-Delhi, she was a National Post Doctoral Fellow (NPDF) at IISER Pune from 2017 to 2019. She worked as a Post Doctoral Fellow at Technion, Israel from 2016 to 2017.',
      'faculty_College':
          'Ph.D. (2017), Harish-Chandra Research Institute, Allahabad',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/debika.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/debika',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907358"',
      'faculty_Office_Address': 'B-310 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': 'Analytic and Probabilistic Number Theory',
      'faculty_Teaching_Interests':
          'Real Analysis,Complex Analysis,Algebra,Number Theory',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/debika',
      'faculty_Website_Page': '/debika',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fdebika%40iiitd.ac.in%2Fdebika.png?alt=media&token=02b99a27-9f98-48b2-b283-c89e69523d55',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Dhruv Kumar',
      'faculty_EmailId': 'dhruv.kumar@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dhruv Kumar is a PhD in Computer Science from University of Minnesota, Twin Cities, USA. He did his post-doc from Microsoft Research. His research is centered around building large scale systems for distributed analytics. His work has been published in venues such as ACM SIGMETRICS, ACM/IEEE SEC, USENIX HotEdge, ACM EdgeSys. Dhruv has been a recipient of 3M Science and Technology fellowship. During his PhD, he has also interned with Google Cloud, California. He graduated from BITS, Pilani in 2014 with a bachelors in Computer Science. At BITS Pilani, he did research on designing and implementing high performance algorithms for shared and distributed memory systems. Prior to joining the PhD program at UMN, Dhruv worked on optimizing the data processing pipelines at Goldman Sachs, Bengaluru.',
      'faculty_College':
          'Ph.D. (2022), University of Minnesota, Twin Cities, USA',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/dhruvk.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/dhruv',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907379"',
      'faculty_Office_Address': 'A-506 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Systems for AI,AI for Systems, Privacy and Security in AI, Technology Education for the Common People',
      'faculty_Teaching_Interests':
          'Operating Systems,Databases\n,Cloud Computing, Data Structures and Algorithms',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/dhruv',
      'faculty_Website_Page': '/dhruv',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fdhruv.kumar%40iiitd.ac.in%2Fdhruv.png?alt=media&token=cc0865e5-841f-456a-8505-83be4c2c2732',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Diptapriyo Majumdar',
      'faculty_EmailId': 'diptapriyo@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Diptapriyo Majumdar obtained his Ph.D. degree in Theoretical Computer Science from The Institute of Mathematical Sciences (IMSc), Chennai, India in October 2018. He has spent 2 years 11 months at Royal Holloway, University of London, United Kingdom as a postdoctoral researcher. He did his B.Tech. in CSE from West Bengal University of Technology and M.Tech in Computer Science from Indian Statistical Institute, Kolkata, India. His research area is primarily in the field of algorithms. He has largely worked in fixed-parameter algorithms for graph theoretic problems. In addition, he has also explored FPT algorithms for CSP based problems arising in access control of information security.',
      'faculty_College':
          'Ph.D. (2018), The Institute of Mathematical Sciences (IMSc), Chennai',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/diptapriyo.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/diptapriyo',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907373"',
      'faculty_Office_Address': 'B-501 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Parameterized Complexity, Graph Algorithms, FPT algorithms for problems arising in access control',
      'faculty_Teaching_Interests':
          'Courses related to algorithms,Discrete Mathematics, Theoretical Computer Science,Optimization',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/diptapriyo',
      'faculty_Website_Page': '/diptapriyo',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fdiptapriyo%40iiitd.ac.in%2Fdiptapriyo.png?alt=media&token=ac23a964-e4e9-4dfd-b587-eaf12513ff19',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Donghoon Chang',
      'faculty_EmailId': 'donghoon@iiitd.ac.in',
      'faculty_Department': 'CSE,Maths',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Bachelor of Mathematics (2001), Korea University, Master of Information Security & Cryptography (2003), Korea University, PhD of Information Security & Cryptography (2008), Korea University, Researcher at University of Waterloo, Canada (2006) Post Doc at Columbia University, USA (2008-2009), Researcher at Computer Security Division, National Institute of Standards and Technology (NIST), USA (2009-2012), Associate Professor, IIIT-Delhi, India (2012-present)',
      'faculty_College': 'PhD (2008), Korea University, Korea',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/donghoon.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/donghoon',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907465"',
      'faculty_Office_Address': 'B-502 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Cryptography, Cryptanalysis, Cyber Security,Information Theory',
      'faculty_Teaching_Interests':
          'Cryptography,Information Theory,Linear & Abstract Algebra,Number Theory.',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/donghoon',
      'faculty_Website_Page': '/donghoon',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fdonghoon%40iiitd.ac.in%2Fdonghoon.png?alt=media&token=a37cd4a7-24b8-4d4d-abee-596173cd542b',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'G.P.S. Raghava',
      'faculty_EmailId': 'raghava@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Head, Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. G. P. S. Raghava received his M.Tech from IIT Delhi and PhD from Institute of Microbial Technology, Chandigarh. He worked as Postdoctoral fellow at Oxford University UK (1996-98), Bioinformatics specialist at UAMS, USA (2002-3 & 2006) and visiting professor at POSTECH, South Korea (2004). He worked as scientist for 30 years (1986-2016) in Institute of Microbial Technology, Chandigarh. His group developed more than 250 web servers, 200 research papers, 80 Copyrights/patents, 35 databases and mirror sites. He got following major awards/recognition i) Shanti Swarup Bhatnagar Award in Biological Science ii) “National Bioscience Award for Carrier Development” for year 2005-2006 (by Department of Biotechnology, Govt. India); iii) J. C. Bose national fellowship 2010 by DST; iv) fellow of National Academy of Sciences (F.N.A.Sc); and v) fellow of Indian Academy of Science (F.A.Sc.) Bangalore.',
      'faculty_College':
          'PhD (1996), Institute of Microbial Technology, Chandigarh',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/raghava.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/raghava',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907444"',
      'faculty_Office_Address': 'A-302 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Application of computer science in the field of biomedical,Artificail intelligence based models for desiging drugs, vaccines and disease biomarkers,Development of open source applications (web servers, standalone software, mobile apps) for serving scientific community working in healthcare',
      'faculty_Teaching_Interests':
          'Application of Artificial Intelligence in Biomedical Sciences,Big Data Mining in Healthcare',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/raghava',
      'faculty_Website_Page': '/raghava',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fraghava%40iiitd.ac.in%2Fraghava.png?alt=media&token=f5c4ae23-20f0-49e3-bf9d-343706b7165e',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Ganesh Bagler',
      'faculty_EmailId': 'bagler@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Complex Systems Laboratory,Infosys Centre for Artificial Intelligence (CAI)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Ganesh Bagler is a computational researcher trained in physics, computer science, and computational biology. Prof. Bagler is well-known for his pioneering research in ‘Computational Gastronomy.’ By building keystone data repositories, algorithms, and applications, he has established the foundations of this emerging data science that blends food with artificial intelligence. Trailblazing research from his lab has significantly contributed to this niche area that deals with food, flavors, nutrition, and public health. A prolific interdisciplinary scientist, voracious reader, science communicator, and TEDx speaker, Ganesh Bagler is an explorer driven by curiosity. He enjoys probing the structure, function, evolution, and design of complex systems (proteins, brain, health, cuisines, languages, and creativity). Prof. Bagler has an audacious dream of transforming the global food landscape by ‘Making Food Computable.’',
      'faculty_College':
          'Ph.D. (2007), CSIR-Centre for Cellular and Molecular Biology',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/gbagler.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/ganeshbagler/',
      'faculty_Website_Url': 'https://iiitd.ac.in/bagler',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907443"',
      'faculty_Office_Address': 'A-305 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Complex Systems,Computational Gastronomy,Computational Biology,Network Science,Bioinformatics,Computational Creativity',
      'faculty_Teaching_Interests':
          'Computational and Systems Biology,Network Science,Network Biology,Computational Gastronomy,Computational Creativity,Philosophy of Science',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/bagler',
      'faculty_Website_Page': '/bagler',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fbagler%40iiitd.ac.in%2Fbagler.png?alt=media&token=3074fe52-8624-4bea-88a4-8c0c8d25f2ba',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Gaurav Ahuja',
      'faculty_EmailId': 'gaurav.ahuja@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Gaurav Ahuja graduated summa cum laude from the University of Cologne, Germany with Ph.D. in Natural Sciences. He is a molecular biologist by training and possesses a vast experience in functional genomics, especially in dissecting complex biological mechanisms using genome-editing and next generation sequencing-based techniques. After the completion of his Ph.D. degree, he worked as a Post Doctoral Fellow at several renowned institutes, including Center for Molecular Medicine Cologne, Max Planck Institute for Ageing and Lee Kong Chian School of Medicine, Singapore. During this period he worked on multiple model systems, including human pluripotent stem cells, zebrafish, mice and killifish. He has published 14 research articles in peer-reviewed International journals (~250 citations). In addition to this, he also reviewed articles submitted to Nature Publishing Group (Cell Death & Diseases and Scientific Reports). Recently, Dr. Ahuja was shortlisted for the prestigious INSPIRE Faculty Fellowship.',
      'faculty_College': 'Ph.D. (2015), University of Cologne, Germany',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/gauravahuja.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/gaurav-ahuja-37bb422b/',
      'faculty_Website_Url': 'https://iiitd.ac.in/gauravahuja',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907475"',
      'faculty_Office_Address': 'A-303 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Identification,Deorphanization and characterization of ectopically expressed GPCRS',
      'faculty_Teaching_Interests':
          'Chemoinformatics,Genetics,Molecular Biology,Biostatistics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/gauravahuja',
      'faculty_Website_Page': '/gauravahuja',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fgaurav.ahuja%40iiitd.ac.in%2Fgauravahuja.png?alt=media&token=1af590a9-79dd-41d2-971d-7a8ce326061d',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Gaurav Arora',
      'faculty_EmailId': 'gaurav@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Gaurav Arora received his Ph.D. in Economics at Iowa State University in January, 2017. As part of his Ph.D. dissertation work, he combined applied economics models with remote sensing tools to study the impacts of local infrastructure, climate change and conservation policy on regional land use changes for Agroecosystems. He also designed and implemented a satellite image-processing algorithm to characterize land use change using historical Landsat sensor data. He was awarded James R. Prescott scholarship in 2016 for outstanding creativity in research, and Earl O. Heady Fellowship in 2012 for academic excellence at the Department of Economics, Iowa State University. Prior to his Ph.D., Gaurav received Master of Science in Agricultural and Resource Economics at the University of Arizona, and Bachelor of Technology in Environmental Engineering at Indian School of Mines, Dhanbad.',
      'faculty_College': 'Ph.D. (2017), Iowa State University',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/gaurava.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/gauravahuja',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907547"',
      'faculty_Office_Address': 'B-206 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Natural Resource & Agricultural Economics,Ecological Economics,Applied Econometrics,Industrial Organization,Applied Game Theory,Spatial Analyses,Remote',
      'faculty_Teaching_Interests':
          'Applied econometrics,Applied microeconomics,Spatial statistics and spatial econometrics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/gaurava',
      'faculty_Website_Page': '/gaurava',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fgaurav%40iiitd.ac.in%2Fgaurava.png?alt=media&token=9e5e3b88-76bf-466e-ba8a-0bb8178b3ddc',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Gayatri Nair',
      'faculty_EmailId': 'gayatri@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Gayatri received her M.Phil (2012) and PhD (2016) in Sociology from the Centre for the Study of Social Systems, Jawaharlal Nehru University, New Delhi. Her research interests lie in urban informal labour and livelihood patterns with an emphasis on the question of technology, caste and gender. With a focus on political economy, she has published work examining the links between caste, gender and cultures of modernity, working caste lives and popular culture. She has published a book on her doctoral research titled 'Set Adrift; Capitalist Transformations and Community Politics Along Mumbai's Shore published by Oxford University Press (2021).",
      'faculty_College': 'PhD (2016), Jawaharlal Nehru University, New Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/gayatri.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/gayatri',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907362"',
      'faculty_Office_Address': 'B-212 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Informal Labour,Urban Informalities,Technology, Gender, and Caste,Digital work and platform economy, Future of Work(ers),Resource-based livelihoods',
      'faculty_Teaching_Interests':
          'Sociological Theory,Technology and Work, Economic Sociology,Urban Sociology',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/gayatri',
      'faculty_Website_Page': '/gayatri',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fgayatri%40iiitd.ac.in%2Fgayatri.png?alt=media&token=128802f4-d938-4695-b628-620c8913e012',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Jainendra Shukla',
      'faculty_EmailId': 'jainendra@iiitd.ac.in',
      'faculty_Department': 'CSE,HCD',
      'faculty_Position': 'Assistant Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Infosys Centre for Artificial Intelligence (CAI),Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative),Human-Machine Interaction Lab (HMI)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Jainendra Shukla completed his Ph.D. in excellent grades with Industrial Doctorate Distinction and International Doctorate Distinction from Universitat Rovira i Virgili (URV), Spain in 2018. He is the recipient of the prestigious Industrial Doctorate research grant by AGAUR, Government of Spain in 2014. He is experienced in human-robot interactions and affect recognition using physiological signals. He is enthusiastic about empowering machines with adaptive interaction ability that can improve the quality of life in health and social care. His research has been disseminated in several journals and conferences of international reputation, including ACM CHI Conference on Human Factors in Computing Systems (CHI), Proceedings of the ACM on Interactive, Mobile, Wearable and Ubiquitous Technologies (IMWUT), IEEE Transactions on Affective Computing. Earlier, he obtained his M.Tech. degree in Information Technology with Specialization in Robotics from Indian Institute of Information Technology, Allahabad (IIIT-A) in 2012 and B.E. degree in Information Technology from the University of Mumbai in First Class with Distinction in 2009.',
      'faculty_College':
          'PhD (2018), Universitat Rovira i Virgili (URV), Spain',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/Jainendra.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/jainendrashukla/',
      'faculty_Website_Url': 'https://iiitd.ac.in/jainendra',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907523"',
      'faculty_Office_Address': 'A-410 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Affective Computing,Human-Computer Interaction,Social Robotics',
      'faculty_Teaching_Interests':
          'Affective Computing,Machine Learning\n,Social Robotics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/jainendra',
      'faculty_Website_Page': '/jainendra',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fjainendra%40iiitd.ac.in%2Fjainendra.png?alt=media&token=da3fbff3-9636-4c5e-adc4-22755bf0749b',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Jaspreet Kaur Dhanjal',
      'faculty_EmailId': 'jaspreet@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'TRUE\n',
      'faculty_Bio':
          'Dr. Jaspreet Kaur Dhanjal received her PhD degree from Indian Institute of Technology Delhi (IITD) in 2019. She has then worked as a Postdoctoral Fellow at the National Institute of Advanced Industrial Science and Technology (AIST), Tsukuba Japan. Her research interests have been at the interface of computation, cellular and molecular biology. In particular, she is interested in studying cancer genomics for designing personalized therapeutics. She is also interested in exploring the mechanism of action of bioactive compounds from natural sources. She has co-authored over 30 papers in peer-reviewed international journals, 04 book chapters and over 10 international conference participation/presentations.',
      'faculty_College': 'PhD (2019), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/jaspreet.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/jaspreet-kaur-dhanjal-6208951a3/',
      'faculty_Website_Url': 'https://iiitd.ac.in/jaspreet',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907522"',
      'faculty_Office_Address': '\nA-307 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Cancer genomics, personalized medicine, drug design and discovery',
      'faculty_Teaching_Interests':
          'Introduction to Quantitative Biology,Cell Biology and Biochemistry',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/jaspreet',
      'faculty_Website_Page': '/jaspreet',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fjaspreet%40iiitd.ac.in%2Fjaspreet.png?alt=media&token=fdf489b3-f4ac-49c4-96fa-874b8e508537',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Kaushik Kalyanaraman',
      'faculty_EmailId': 'kaushik@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Head, Assistant Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Kaushik Kalyanaraman is an applied and computational mathematician. He trained to be an electrical engineer (bachelor's and master's degrees), chose to be a computer scientist (doctoral degree) and now identifies as an applied mathematician. His degrees are from Anna University Chennai, Indian Institute of Technology Bombay, and the University of Illinois at Urbana-Champaign in that order. Kaushik's research interests are interdisciplinary and span applied math, computer science and engineering. His honors include a best paper award at ACM-SIAM SPM 2012, and being an invitee to the inaugural Heidelberg laureate forum in 2013. Kaushik has also had a brief industrial stint with the former TATA company Computational Research Labs in Pune, India before his Ph.D. and a research stint at Rensselaer Polytechnic Institute in Troy, NY after. Philosophies of computing, math and science are a side interest which he tries to cultivate during his personal time.",
      'faculty_College':
          'Ph.D. (2015), University of Illinois at Urbana-Champaign',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/kaushik.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/kaushik',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907537"',
      'faculty_Office_Address': 'B-302 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Applied and Computational Analysis,Geometry and Topology',
      'faculty_Teaching_Interests':
          'Scientific computing, numerical ODEs and PDEs',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/kaushik',
      'faculty_Website_Page': '/kaushik',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fkaushik%40iiitd.ac.in%2Fkaushik.png?alt=media&token=8656b7a1-ee64-421f-bc82-9a435742ce41',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Kiriti Kanjilal',
      'faculty_EmailId': 'kanjilal@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Head, Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Kiriti Kanjilal completed his 5 year Integrated Masters in Economics at the University of Hyderabad in 2013 and defended his Ph.D. in Economics at Washington State University in May 2018. His dissertation was titled Essays in Behavioral Industrial Organization and Natural Resource Economics. His research interests are primarily in the fields of microeconomics, game theory, industrial organization, environmental economics and behavioral economics. He also has experience in conducting economic experiments. He uses Mathematica, Stata and z-Tree for research. Apart from research, he also has taught courses in macroeconomics and finance during his Ph.D.',
      'faculty_College': 'Ph.D. (2018), Washington State University',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/kanjilal.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/kiriti-kanjilal-b6824a37/',
      'faculty_Website_Url': 'https://iiitd.ac.in/kanjilal',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907558"',
      'faculty_Office_Address': 'B-208 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Industrial Organization,Applied Game Theory,Behavioural and Experimental Economics,Natural Resource Economics',
      'faculty_Teaching_Interests':
          'Game Theory,Industrial Organization,Macroeconomics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/kanjilal',
      'faculty_Website_Page': '/kanjilal',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fkanjilal%40iiitd.ac.in%2Fkanjilal.png?alt=media&token=85601427-b778-4ac7-aba8-f08c1de36082',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Koteswar Rao Jerripothula',
      'faculty_EmailId': 'koteswar@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Koteswar is currently working as an Assistant Professor at IIIT-Delhi in the CSE Department. He received his B.Tech degree from IIT Roorkee, India, in 2012, and PhD degree from Nanyang Technological University (NTU), Singapore, in 2017. In 2016, he did a research internship at Advanced Digital Sciences Center (ADSC), Singapore. He has also worked with Graphic Era and Lenskart earlier. His research interests are Computer Vision and Machine Learning. He is currently focusing primarily on object co-segmentation, saliency detection, semi-supervised learning and weakly supervised learning. Some of his works have been published in top/popular venues like CVPR, ECCV, TMM, TCSVT, etc.',
      'faculty_College':
          'PhD (2017), Nanyang Technological University (NTU), Singapore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/koteswar.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/koteswar-rao-jerripothula/',
      'faculty_Website_Url': 'https://iiitd.ac.in/koteswar',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907433"',
      'faculty_Office_Address': 'B-405 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Computer Vision,Image Processing,Multimedia Systems,Machine Learning and Artificial Intelligence',
      'faculty_Teaching_Interests':
          'Computer Vision,Image Processing,Machine Learning and Programming',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/koteswar',
      'faculty_Website_Page': '/koteswar',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fkoteswar%40iiitd.ac.in%2Fkoteswar.png?alt=media&token=5f8cefb2-f402-4aaa-867f-048e71eba9ac',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Manohar Kumar',
      'faculty_EmailId': 'manohar.kumar@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Manohar Kumar completed his PhD in Political Theory from LUISS University, Rome in 2013. He has a Masters in Development Studies from Tata Institute of Social Sciences, Mumbai and a Bachelors in Economics from Hindu College, University of Delhi.He is currently finishing a co-authored book project titled ‘Speaking Truth to Power. A Theory of Whistleblowing’ slated to be published in 2018.Prior to joining IIIT-Delhi, Manohar held postdoctoral fellowships at IIT Delhi (2015-2017) and AMSE, Aix Marseille University (2017-2018).',
      'faculty_College': 'PhD (2013), LUISS University, Rome',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/Manohar-Kumar.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/manohark',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907557"',
      'faculty_Office_Address': 'B-207 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Moral and Political Philosophy,Digital dissent,Digital citizenship,Whistleblowing,Civil disobedience,Democratic secrecy and epistemic injustice.',
      'faculty_Teaching_Interests':
          'Social and Political Philosophy,Applied Ethics,Moral Philosophy,Ethics of AI',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/manohark',
      'faculty_Website_Page': '/manohark',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fmanohar.kumar%40iiitd.ac.in%2Fmanohark.png?alt=media&token=6746c81d-9c27-4cc6-9e70-16dfcbdea54f',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Manuj Mukherjee',
      'faculty_EmailId': 'manuj@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Manuj Mukherjee received his PhD from the Indian Institute of Science in 2017. Following his PhD, he did a couple of stints as a postdoc, at Telecom Paris, France, and at Bar Ilan University, Israel. He has regularly published in top tier journals and conferences of IEEE Information Theory Society. He is the recipient of the Seshagiri Kaikini Medal from the Electrical Communication Engineering department of the Indian Institute of Science for the best PhD thesis in the year 2017-2018.His research interests include the broad neighborhood of information theory in general with a particular focus on multiparty communication.',
      'faculty_College':
          'Ph.D. (2017), Indian Institute of Science, Bengaluru, India',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/manuj.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/manuj-mukherjee-4644ba251/',
      'faculty_Website_Url': 'https://iiitd.ac.in/manuj',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907376"',
      'faculty_Office_Address': 'A-608 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Information Theory,Multiparty interactive communication,Interactive coding',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/manuj',
      'faculty_Website_Page': '/manuj',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fmanuj%40iiitd.ac.in%2Fmanuj.png?alt=media&token=90cd5ca4-4aef-4f0b-8e1c-ee39cc379999',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Md. Shad Akhtar',
      'faculty_EmailId': 'shad.akhtar@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Md. Shad Akhtar completed his Ph.D. in Computer Science and Engineering from IIT Patna in 2019. He received his M.Tech from IIT (ISM), Dhanbad in 2014, and BEng from JMI, New Delhi, in 2009. He also has industry experience of more than two years with HCL Technologies Ltd. He has published research papers in various peer-reviewed conferences and journals of international repute. He has also served as the program committee member and reviewer for numerous international conferences and journals.His main areas of research are Sentiment and Emotion Analysis in the Natural Language Processing domain. Currently, his area of interest focuses on Dialog Management and Multimodal Analysis.',
      'faculty_College': 'PhD (2019), IIT Patna, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/shad.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/shadakhtar/',
      'faculty_Website_Url': 'https://iiitd.ac.in/shad',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907365"',
      'faculty_Office_Address': 'B-406 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Sentiment Analysis,Emotion Analysis,Conversational Dialog Systems,Code-mixed Languages,Multimodal Analysis',
      'faculty_Teaching_Interests': 'Natural Language Processing,Deep Learning',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/shad',
      'faculty_Website_Page': '/shad',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fshad.akhtar%40iiitd.ac.in%2Fshad.png?alt=media&token=a26c7976-492f-468f-9efe-59589b074b1e',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Monika Arora',
      'faculty_EmailId': 'monika@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Monika Arora defended her Ph.D. thesis in Computational & Applied Mathematics from Old Dominion University, Virginia, USA in May 2018. She did her M.Sc. in Applied Statistics and Informatics (ASI) from Indian Institute of Technology (IIT), Bombay, India in May 2011. After her M.Sc. she worked for two years as a lead scientist in statistical modeling at a start up incubated by IIT-Bombay. Her current areas of research are count data and statistical modeling. She works on univariate and bivariate count models which are applied in various fields, e.g., health science, travel, insurance and ecology. Her research involves both theoretical and computational techniques to develop the models. She uses statistical softwares like R and SAS for her research.',
      'faculty_College': 'Ph.D. (2018), Old Dominion University, Virginia, USA',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/monika.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/monika',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907587"',
      'faculty_Office_Address': 'A-304 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': 'Count data and statistical modeling',
      'faculty_Teaching_Interests':
          'Statistical Inference,Categorical data,Stochastic Processes',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/monika',
      'faculty_Website_Page': '/monika',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fmonika%40iiitd.ac.in%2Fmonika.png?alt=media&token=f92d4bb1-c884-4c0f-89a4-cd1192393a12',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Mrinmoy Chakrabarty',
      'faculty_EmailId': 'mrinmoy@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Mrinmoy Chakrabarty carried out his doctoral training with a fellowship from the Interdisciplinary Program for Biomedical Sciences of Osaka University, Japan and earned his Ph.D. with Distinction at Osaka University Graduate School of Medicine in March 2017. He was a Post-Doctoral Research Fellow in the Dept. of Rehabilitation for Brain Functions at National Rehabilitation Center for Persons with Disabilities, Japan [WHO Collaborating Center] from April 2017 until joining IIIT-Delhi in December 2019. His present experimental research employs psychophysics, psychophysiology and neuroimaging with computational data analysis to study cognitive functions in samples of clinical as well as healthy human populations.',
      'faculty_College': 'PhD (2017), Osaka University, Japan',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/mrinmoy.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/mrinmoy',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907363"',
      'faculty_Office_Address': 'A-202 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Affective Cognitive Neuroscience,Visual-Spatial Cognition,Autism Spectrum Disorders,Decision Making,Learning-Memory,Anxiety Disorders',
      'faculty_Teaching_Interests': 'Learning and Memory,Decision Making',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/mrinmoy',
      'faculty_Website_Page': '/mrinmoy',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fmrinmoy%40iiitd.ac.in%2Fmrinmoy.png?alt=media&token=a4ad4df2-e7cb-43b2-99a8-b7c7bb8bba86',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Mukesh Mohania',
      'faculty_EmailId': 'mukesh@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Mukesh Mohania received his Ph.D. in Computer Science & Engineering from Indian Institute of Technology - Bombay, India in 1995. He was a faculty member in University of South Australia and Western Michigan University from 1995-2001, and then worked at IBM Research (India and Australia) for 18+ years till October 2019 as Distinguished Engineer.His research interests are on Information (structured and unstructured data) integration, master data management, AI based entity analytics, big data analytics and applications, and blockchain data management. His work in these areas has led to the development of new products and also influenced several existing IBM products. He has received several awards within IBM, such as "Best of IBM", “Outstanding Innovation Award”, "Outstanding Technical Achievement Award", and many more. He has published more than 120 Research papers in reputed International Conferences and Journals and has more than 50 granted patents. He has held several visible positions in academia and professional activities, like Adjunct Professor at Australian National University and University of Melbourne, VLDB 2016 Conference Organising Chair, ACM India Vice-President (2015-2017), ACM Distinguished Service Award Committee Chair (2017-18), Distinguished Speaker Program Chair (2015-17), and editorial board member in several journals and transactions. He is an ACM Distinguished Scientist, a recipient of ACM Outstanding Service Award, and an IEEE Meritorious Award. He was a member of IBM Academy of Technology, and IBM Master Inventor.',
      'faculty_College':
          'PhD (1995), Indian Institute of Technology Bombay, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/public/faculty/mukesh.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/mukesh-mohania-4755606/',
      'faculty_Website_Url': 'https://iiitd.ac.in/mukesh',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907355"',
      'faculty_Office_Address': 'A-507 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Information Integration,Entity Discovery and Analytics,Big Data Analytics and Applications,Blockchain Data Management',
      'faculty_Teaching_Interests':
          'Information Management and Data Integration',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/mukesh',
      'faculty_Website_Page': '/mukesh',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fmukesh%40iiitd.ac.in%2Fmukesh.png?alt=media&token=cc960f13-5618-4207-8e81-81f8361b4308',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Mukulika Maity',
      'faculty_EmailId': 'mukulika@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Mukulika Maity joined as an assistant professor at the computer science department of IIIT- Delhi in April 2017. She received her M.Tech. + Ph.D. dual degree from computer science department of IIT Bombay in 2017. Her PhD advisors were Prof. Bhaskaran Raman and Prof. Mythili Vutukuru. She received her B.E. in 2010 in the computer science department of Bengal Engineering and Science University, Shibpur. Her research interests lie in developing networked systems solutions, designing solutions for dense WiFi networks, and developing mobile system solutions. She has been awarded the Early Career Research award by SERB in 2019. She is working on multiple projects funded by various organizations such as SERB, NSC. She is interested in developing solutions for unique systems/networking challenges faced by developing countries.',
      'faculty_College': 'PhD (2016), IIT Bombay, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/mukulikam.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/mukulika-maity-45420521/',
      'faculty_Website_Url': 'https://iiitd.ac.in/mukulika',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907471"',
      'faculty_Office_Address': 'B-509 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Networked Systems,Wireless Networks,Mobile Systems',
      'faculty_Teaching_Interests':
          'Computer Networks,Wireless Networks,Mobile computing',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/mukulika',
      'faculty_Website_Page': '/mukulika',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fmukulika%40iiitd.ac.in%2Fmukulika.png?alt=media&token=d6b339c0-bdfb-4447-9960-28bb66503c40',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'N. Arul Murugan',
      'faculty_EmailId': 'arul.murugan@iiitd.ac.in.',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. N. Arul Murugan, is a Ph.D. from Solid State and Structural Chemistry unit at Indian Institute of Science, Bangalore, India). He was awarded a Ph.D. degree in the year 2005 for his thesis contribution entitled "Molecular simulations of temperature induced disorder and pressure induced ordering in organic molecular crystals." After Ph.D., he was on postdoctoral visits to various institutes in Europe such as ULB (Brussels, Belgium), KTH (Stockholm, Sweden) and UPC (Barcelona, Spain) until 2011, and his research stays were supported generously by the prestigious fellowships from Belgian national fund for scientific research (FNRS), Wenner-Gren foundation and Spanish Ministry of Science and Innovation (for Juan de La Cierva fellowship). From the year 2011, he was employed as a researcher at the School of Biotechnology, KTH Royal Institute of Technology and from 2015 he was appointed as a Docent (Associate Professor) in theoretical chemistry and Biology at the same school. He has been involved in teaching and supervision at KTH since the year 2013.  His research focuses on the computational development of drugs and PET tracers/optical probes for neurodegenerative diseases such as Alzheimer\'s disease and Parkinson\'s disease and infectious diseases including Covid-19. His research is also devoted to the development of QM and machine learning based approaches for druggability prediction. He has published about 120 articles in international peer-reviewed journals including Sci.Adv., PNAS, JACS, Biosens.& Bioelectron., JMedChem, JCTC, JPClett., He has also written 3 book chapters and edited a book.  He is serving as an editorial board member for Scientific Reports and IJMS and is currently editing a special issue on Covid-19 therapeutics and diagnostics for the IJMS journal.',
      'faculty_College':
          'Ph.D. (2005), Indian Institute of Science, Bangalore, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/arulmurugan.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/n-arul-murugan-phd-docent-12a93a10/',
      'faculty_Website_Url': 'https://iiitd.ac.in/arulmurugan',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"01126907372"',
      'faculty_Office_Address': 'A-311 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'ML and DL approaches for Druggability prediction,QM fragmentation based approaches for Druggability prediction,Parallel virtual screening in HPCs and GPUs for accelerated drugs discovery,Flexible docking assisted Drugs discovery,Atomistic simulation of virus-host cell interaction',
      'faculty_Teaching_Interests':
          'Algorithms in Computational Biology Cheminformatics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/arulmurugan',
      'faculty_Website_Page': '/arulmurugan',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Farul.murugan%40iiitd.ac.in.%2Farulmurugan.png?alt=media&token=15908d16-70bc-4339-b6cc-97a0c04235a7',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Nishad Patnaik',
      'faculty_EmailId': 'nishad@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Nishad received his PhD in philosophy from The New School for Social Research (NSSR), New York, U.S.A in 2013. He holds a M.A. in philosophy from NSSR, as well as a M.A. and M.Phil. in philosophy from Delhi University. His dissertation entitled, “Time, Space and Finitude; Kant and Husserl on the Question of Transcendental Logic” received the ‘Alfred Schutz Memorial Award in Philosophy and Sociology’. In addition to his research interests in Kantian transcendental Idealism, and Husserlian phenomenology, Nishad’s other areas of research include Social and Political Philosophy, Marx and the Critical Theory tradition, Ethics, and the Philosophy of Technology. He is currently engaged in writing a book length manuscript on the genealogy of nationalist identity and its apparently paradoxical reassertion in the context of the hegemony of the contemporary capitalist world order.Before joining IIITD, he was a visiting assistant professor at IIIT Hyderabad (2018-19), Visiting Fellow at J.N.U. (2015-17), and held visiting faculty positions at IIT Delhi (2015-16), St. Stephen’s College, Delhi (2016-17) and Westchester Community College, New York, 2013-14.',
      'faculty_College': 'PhD (2013), NSSR, New York, USA',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/nishad.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/nishad',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907364"',
      'faculty_Office_Address': 'A-205 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Kantian transcendental Idealism,Husserlian phenomenology,Social and Political Philosophy',
      'faculty_Teaching_Interests':
          'Kantian transcendental Idealism,Husserlian phenomenology,Social and Political Philosophy',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/nishad',
      'faculty_Website_Page': '/nishad',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fnishad%40iiitd.ac.in%2Fnishad.png?alt=media&token=9964ddbd-cb22-4a8b-ae97-ff46d9a2d2e3',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Ojaswa Sharma',
      'faculty_EmailId': 'ojaswa@iiitd.ac.in',
      'faculty_Department': 'CSE,Maths',
      'faculty_Position': 'Head, Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Graphics Research Group (GRG),Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Ojaswa Sharma is an associate professor at the Indraprastha Institute of Information Technology Delhi. He completed his Ph.D. in Mathematics and Computer Science from the Technical University of Denmark, Denmark. He has more than four years of experience with corporate R&D. His research spans various aspects of Computer Graphics, and Computational Geometry. In particular his work focuses on Geometry creation and reconstruction, Virtual/Augmented Reality (AR/VR), Volume rendering, and high performance computing on GPU. He leads the Graphics Research Group (GRG) at IIIT-Delhi.',
      'faculty_College': 'PhD (2010), Technical University of Denmark, Denmark',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/ojaswa.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/ojaswasharma/',
      'faculty_Website_Url': 'https://iiitd.ac.in/ojaswa',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907476"',
      'faculty_Office_Address': 'A-511 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Computer graphics and geometry with focus on Virtual and Mixed reality (VR/MR),Volume rendering,3D reconstruction,High performance computing on GPU',
      'faculty_Teaching_Interests':
          'Computer graphics and geometry with focus on Virtual and Mixed reality (VR/MR),Volume rendering,3D reconstruction,High performance computing on GPU',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/ojaswa',
      'faculty_Website_Page': '/ojaswa',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fojaswa%40iiitd.ac.in%2Fojaswa.png?alt=media&token=1e7d6d06-3f91-4f52-8929-50dbd02b7149',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Pankaj Jalote',
      'faculty_EmailId': 'jalote@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Distinguished Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Pankaj Jalote is currently a Distinguished Professor (CSE). He was the founding Director of IIIT-Delhi from 2008-2018. Earlier, he has also been an Assistant Professor at University of Maryland College Park, Professor and Head of Computer Science Department at IIT Kanpur, and Chair Professor at IIT Delhi, . He has also been Vice President at Infosys for 2 years, Visiting Researcher at Microsoft in Redmond for 1 year, and Interim Vice Chancellor of Delhi Technological University (DTU) for six months. He has a B.Tech. from IIT Kanpur, MS from Pennsylvania State University, and Ph.D. from University of Illinois at Urbana-Champaign. He is the author of five books, some of which have been translated in Chinese, Japanese, Korean etc, and the Indian edition of his text on Software Engineering was adjudged the bestselling book by the publisher. His main area of interest is Software Engineering and Higher Education. He has served on the editorial boards of IEEE Transactions on Software Engineering, Intl. Journal on Empirical Software Engineering, and IEEE Trans. on Services Computing. He is a Fellow of the IEEE and INAE.',
      'faculty_College':
          'PhD (1985), University of Illinois at Urbana Champaign, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/jalote.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/pankaj-jalote-0924782/',
      'faculty_Website_Url': 'https://iiitd.ac.in/jalote',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907499"',
      'faculty_Office_Address': 'A-705 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Software quality, process improvement,Higher Education in India',
      'faculty_Teaching_Interests':
          'Software Engineering, Quantitative Methods in Software Engineering E-Commerce, Effective Teaching, Technical Communication.',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/jalote',
      'faculty_Website_Page': '/jalote',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fjalote%40iiitd.ac.in%2Fjalote.png?alt=media&token=586a5950-eea6-4558-8b26-dd031727aa16',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Paro Mishra',
      'faculty_EmailId': 'paro.mishra@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'TRUE\n',
      'faculty_Bio':
          "Paro received her Ph.D. from the Department of Humanities and Social Sciences, Indian Institute of Technology, Delhi in 2017. Her core research interests lie at the intersection of Gender and Technology – New Reproductive Technologies (NRTs) and Information/ Digital Technologies, in particular. She has published on intimate migrations, masculinity, aging, care circulation, care work and gendered surveillance. Paro has received several fellowships and grants from the Netherlands Institute for Advanced Studies, University Grants Commission, IIT Delhi and the Indian Council of Social Science Research. She has recently finished a project on sex-selective technologies, male marriage squeeze and cross-cultural intimacies funded by the Indian Council of Social Science Research (2018). Her current research is examining intersections of Gender, Health and Digital Technologies with a focus on emerging FemTech Landscape in India. This project is funded by IIITD-IITD MFIRP Scheme. Select publications include special issues co-editorship for Asian Bioethics Review (2021) and Asian Journal of Women's Studies and in Journals like Anthropology and Aging, The Sociological Review, Economic & Political Weekly, and Society and Culture in South Asia.",
      'faculty_College': 'PhD (2017), IIT-Delhi',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/paro.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/paro-mishra-806171184/',
      'faculty_Website_Url': 'https://iiitd.ac.in/paro',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907570"',
      'faculty_Office_Address': 'B-209 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Gender and Technology,New reproductive Technologies,Digital Technologies,Demographic Anthropology,Intimate Relations,Migration and Transnationalism',
      'faculty_Teaching_Interests':
          'Enhancement Technologies and Body,Contemporary Indian Society,Digital Intimacy,Gender Studies, Migration and Transnationalism',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/paro',
      'faculty_Website_Page': '/paro',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fparo.mishra%40iiitd.ac.in%2Fparo.png?alt=media&token=73185840-7788-418a-ac3e-64e6a4971d68',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Piyus Kedia',
      'faculty_EmailId': 'piyus@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Piyus has obtained his Ph.D. from IIT Delhi and subsequently worked as a post-doctoral Research Fellow at Microsoft Research India. He has worked on deterministic replay of multiprocessor virtual machine for his Ph.D. thesis. His recent work proposes a safe manual management scheme for safe languages which is remarkably faster than garbage collection. His current work focuses on building safe operating systems for IOT devices.',
      'faculty_College': 'PhD (2018), IIT-Delhi, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/piyuskedia.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/piyus-kedia-2b397526a/',
      'faculty_Website_Url': 'https://iiitd.ac.in/piyus',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907528"',
      'faculty_Office_Address': 'B-505 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'System security, safe languages, virtualization and dynamic/static techniques to build systems',
      'faculty_Teaching_Interests':
          'System security, safe languages, virtualization and dynamic/static techniques to build systems',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/piyus',
      'faculty_Website_Page': '/piyus',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fpiyus%40iiitd.ac.in%2Fpiyus.png?alt=media&token=7a5a9e65-19d8-4e34-b61b-f4c843667544',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Praveen Priyadarshi',
      'faculty_EmailId': 'praveen@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Praveen Priyadarshi completed his Ph.D. in Development Studies from London School of Economics and Political Science (LSE), London. His academic interest lies at the intersections of the categories of space, institutions and policy especially in the urban context. He brings these categories to bear upon his understanding of contemporary politics in India and the Global South. Before joining us, Praveen has been an Assistant Professor in the Department of Political Science, Zakir Husain Delhi College, Evening, University of Delhi (DU). His publications include papers in Economic and Political Weekly (EPW) and a co-edited book from Pearson Longman, titled Contemporary India: Economy, Society, Politics. He has been an Associate at the Crisis States Research Centre, LSE, and at the Developing Countries Research Centre (DCRC), University of Delhi. He was the Tata Ph.D. Fellow at the Asia Research Centre (ARC), at the London School of Economics.',
      'faculty_College':
          'Ph.D. London School of Economics and Political Science, London',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/praveen.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/praveenpriyadarshi/',
      'faculty_Website_Url': 'https://iiitd.ac.in/praveen',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907359"',
      'faculty_Office_Address': 'A-203 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Distinctiveness of everyday political practices in new urban spaces',
      'faculty_Teaching_Interests':
          'Smart Cities,Urban Politics,Indian Democracy',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/praveen',
      'faculty_Website_Page': '/praveen',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fpraveen%40iiitd.ac.in%2Fpraveen.png?alt=media&token=7170f0be-434c-414a-b45f-11b477a58447',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Pravesh Biyani',
      'faculty_EmailId': 'praveshb@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'TRUE\n',
      'faculty_Bio':
          'I was born in Raigarh, India and received my B.Tech from IIT Bombay in 2002 and MS from McMaster University in the year 2004. I have also worked at the Ikanos Communications while pursuing my Ph.D. at the IIT Delhi till early 2012. In the later 2012, I was a post- doctoral researcher at the University of Minnesota, Minneapolis with Prof. Tom Luo. I have won the INSPIRE Faculty award by the Govt. of India in 2012 and am currently an INSPIRE faculty at the IIIT Delhi. My research interests are physical layer wireless and wireline communications, optimization for signal processing and machine learning. Recently I have developed interest in applying ideas from Convex Optimization in solving problems in urban transportation, specially the bus route network design problem.',
      'faculty_College': '\nPh.D. (2012), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/pravesh.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/praveshbiyani/',
      'faculty_Website_Url': 'https://iiitd.ac.in/praveshb',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907449"',
      'faculty_Office_Address': '\nA-604 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Optimisation for signal processing and communications,Machine learning, and transportation.',
      'faculty_Teaching_Interests':
          'Signal Processing,Optimisation,Communications.',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/praveshb',
      'faculty_Website_Page': '/praveshb',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fpraveshb%40iiitd.ac.in%2Fpraveshb.png?alt=media&token=438e2253-2819-4556-ba0f-b1ceec23cedb',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Pushpendra Singh',
      'faculty_EmailId': 'psingh@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Pushpendra Singh is a Professor at Indraprastha Institute of Information Technology (IIITD), New Delhi. He completed his Ph.D. in 2004 from Inria-Rennes, France in the area of mobile computing. He worked at Portsmouth University, Newcastle University, and Inria-Rocquencourt before IIITD. His primary research interest areas are mobile systems and applications, middleware, and ICT for Development. His work has been successfully transferred to Industry in the past leading to creation of start-ups and new products. His research is funded by DEiTY, ITRA, DST, DRDO, CEFIPRA etc. His work has been deployed in the field for various projects including in projects related to national schemes such as NRHM (National Rural Health Mission) and NREGS (National Rural Employment Guarantee Scheme). Pushpendra Singh has also been appointed Nodal Officer by Govt. of NCT, Delhi for running 181-Women-in-distress helpline. All the software for the helpline has been developed by the team of Pushpendra.',
      'faculty_College':
          'PhD (2004), Inria-Rennes, University de Rennes 1, France',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/puspendra.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/pushpendras/',
      'faculty_Website_Url': 'https://iiitd.ac.in/pushpendra',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907458"',
      'faculty_Office_Address': 'A-502 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Mobile Systems and Applications,Middleware,ICT for Development',
      'faculty_Teaching_Interests':
          'Operating Systems,Computer Networks,Mobile Computing.',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/pushpendra',
      'faculty_Website_Page': '/pushpendra',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fpsingh%40iiitd.ac.in%2Fpushpendra.png?alt=media&token=1463a5c7-7830-466a-86a9-1ca9df6e4315',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Rajiv Raman',
      'faculty_EmailId': 'rajiv@iiitd.ac.in',
      'faculty_Department': 'CSE,Maths',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'My primary area of research is algorithms. I am interested in the design and analysis of algorithms for problems in various domains such as scheduling, resource allocation, graph colouring and geometry. I also have an interest in the development of efficient practical heuristics for real-life problems. I obtained a PhD degree in Computer Science from the University of Iowa in 2007. Since then, I worked as a postdoctoral fellow at the Max-Planck institute for informatics in Germany, and at the centre for Discrete Mathematics and Applications at the University of Warwick. I also worked briefly at TCS Innovation labs before joining IIIT in 2012.',
      'faculty_College': 'PhD (2007), University of Iowa, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/rajiv.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/rajiv',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907573"',
      'faculty_Office_Address': 'B-507 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Algorithms,Combinatorial Optimization,Graph Theory,discrete and computational geometry',
      'faculty_Teaching_Interests':
          'Algorithms,Discrete mathematics,Optimization,Graph theory',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/rajiv',
      'faculty_Website_Page': '/rajiv',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Frajiv%40iiitd.ac.in%2Frajiv.png?alt=media&token=fdcb9ecd-3d65-40f5-9187-ef19d6e2f8dc',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Rajiv Ratn Shah',
      'faculty_EmailId': 'rajivratn@iiitd.ac.in',
      'faculty_Department': 'CSE,HCD',
      'faculty_Position': 'Head, Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Rajiv Ratn Shah received his Ph.D. in computer science from the National University of Singapore, Singapore. Prior completing his Ph.D., he received his M.Tech. and MCA degrees in computer applications from the Delhi Technological University, Delhi and Jawaharlal Nehru University, Delhi, respectively. He has also received his BSc in Mathematics (Honors) from the Banaras Hindu University, Varanasi. Dr Shah is the recipient of several awards, including the prestigious European Research Consortium for Informatics and Mathematics (ERCIM) Fellowship and runner-up in the Grand Challenge competition of ACM International Conference on Multimedia. He is involved in organizing and reviewing of many top-tier international conferences and journals. After joining IIITD in Dec 2016, he has spent 1 year as a Research Fellow in Living Analytics Research Center (LARC) at the Singapore Management University, Singapore.',
      'faculty_College':
          'PhD (2017), National University of Singapore, Singapore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/ratn.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/rajivratn/',
      'faculty_Website_Url': 'https://iiitd.ac.in/rajivratn',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907495"',
      'faculty_Office_Address': 'A-409 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Multimodal semantic and sentiment analysis of user-generated social media content,NLP Speech ProcessingComputer VisionMultimodal Computing',
      'faculty_Teaching_Interests':
          'Deep learning based multimedia systems,Information Retrieval,HCI, Multimedia Content Analysis',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/rajivratn',
      'faculty_Website_Page': '/rajivratn',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Frajivratn%40iiitd.ac.in%2Frajivratn.png?alt=media&token=f3a62a95-ea43-41ac-9898-6a49bbff893d',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Rakesh Chaturvedi',
      'faculty_EmailId': 'rakesh@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Rakesh Chaturvedi completed his Ph.D. in Economics from Pennsylvania State University in 2015. He uses mathematical modeling and analysis in his research. His recent and ongoing work aims to design good mechanisms for resource allocation problems. Some of his current areas of interest are problems in market design and game theory. Before his PhD, Rakesh obtained his Masters degree in Economics from Delhi School of Economics and his undergraduate degree in Mining Engineering from Institute of Technology at Banaras Hindu University. Before joining IIITD, Rakesh was a faculty at Indian Institute of Management Udaipur during 2015-2017 and an adjunct faculty at Delhi School of Economics during 2008-09',
      'faculty_College': 'Ph.D. (2015), Pennsylvania State University',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/rakeshc.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/rakesh',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907535"',
      'faculty_Office_Address': 'B-205 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': 'Market Design,Game Theory,Microeconomics',
      'faculty_Teaching_Interests': 'Market Design,Game Theory,Microeconomics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/rakesh',
      'faculty_Website_Page': '/rakesh',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Frakesh%40iiitd.ac.in%2Frakesh.png?alt=media&token=d980bd99-2b87-4cb7-abaf-d99d5a7928f1',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Ram Krishna Ghosh',
      'faculty_EmailId': 'rkghosh@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Dr. Ram Krishna Ghosh obtained his Ph.D. from the Department of Electronic Systems Engineering, Indian Institute of Science, Bangalore in 2013. He has experience in computational nanoelectronics, particularly in the area of 'materials-devices co-design' of next-generation CMOS and beyond CMOS computing. He has worked as a post-doctoral fellow at the Pennsylvania State University and the University of Notre Dame, USA. He has been a DST Inspire Faculty at the Jawaharlal Nehru University, New Delhi, before joining IIIT-Delhi. He is the recipient of the Best Ph.D. thesis award (Tag Corporation Medal) from the Council of Indian Institute of Science, Bangalore. He is also a recipient of Inspire Faculty Award from DST and the Early Career Research Award from SERB.His current research interests include computational materials design (primarily, ab-initio Density Functional Theory and Molecular Dynamics simulations), quantum transport simulations, and multiscale modeling of emerging electronic, spintronic, and photovoltaic devices.",
      'faculty_College': 'Ph.D. (2013), Indian Institute of Science, Bangalore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/rkghosh.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/ram-krishna-ghosh-ba334b65/',
      'faculty_Website_Url': 'https://iiitd.ac.in/rkghosh',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907367"',
      'faculty_Office_Address': '\nB-601 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Computational nanoelectronics, spintronics, quantum transport simulation, device modeling, materials modeling, and multiscale modeling',
      'faculty_Teaching_Interests':
          'Electronics, Semiconductor Device Physics, Nanoscale Devices, Advanced CMOS and beyond CMOS Devices, Quantum Materials and Devices, etc.',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/rkghosh',
      'faculty_Website_Page': '/rkghosh',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Frkghosh%40iiitd.ac.in%2Frkghosh.png?alt=media&token=c7cc3864-6b45-4fb4-ab74-edf72f308073',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Ranjan Bose',
      'faculty_EmailId': 'bose@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Director and Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Ranjan Bose is the Director of the Institute. Prior to joining IIIT-Delhi, he was Microsoft Chair Professor in the Department of Electrical Engineering at IIT-Delhi. He has also served as the Head of Bharti School of Telecom Technology and Management and as the founding Head of Center of Excellence in Cyber Systems and Information Assurance at IIT-Delhi.He received his B.Tech. degree in Electrical Engineering from IIT Kanpur and M.S. and Ph.D. degrees in Electrical Engineering from University of Pennsylvania, Philadelphia, USA.He is the author of the book Information Theory, Coding and Cryptography (3rd Ed.). This book has an international edition and has been translated into Chinese and Korean. He is the national coordinator for the MHRD Mission Project on Virtual Labs, which enables students all over the country to perform laboratory experiments remotely. He has also contributed to the National Program on Technology Enhanced Learning (NPTEL) and the National Pedagogy Project. He has served on the editorial boards of IEEE Access and Computers & Security (Elsevier), and has been the Editor-in-Chief of IETE Journal of Education. He has also been on the Security Advisory Board of GSTN.He is the recipient of the URSI Young Scientist award, the Indian National Academy of Engineers (INAE) Young Engineers Award, the AICTE Career Award for Young Teachers, the BOYSCAST Fellowship and Dr. Vikram Sarabhai Research Award.He is Fellow of IET (UK) and Humboldt Fellow (Germany).',
      'faculty_College':
          'PhD (1995), University of Pennsylvania, Philadelphia, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/rbose_0.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/ranjanbose/',
      'faculty_Website_Url': 'https://iiitd.ac.in/bose',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907481"',
      'faculty_Office_Address': 'A-707 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Secure Communications,Coding Theory,5G Security,Wireless Security,Physical Layer Security and Broadband Wireless Access',
      'faculty_Teaching_Interests':
          'Information Theory,Coding Theory,Physical Layer Security,Wireless Communications',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/bose',
      'faculty_Website_Page': '/bose',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fbose%40iiitd.ac.in%2Fbose.png?alt=media&token=f70f5a5a-23b4-4930-ae02-4c9d951843c6',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Ranjitha Prasad',
      'faculty_EmailId': 'ranjitha@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Ranjitha Prasad obtained her Ph.D. from Indian Institute of Science in 2015. Her experience is in the general areas of signal processing, Bayesian statistics, and more recently, machine learning and deep neural networks. She has been a postdoctoral researcher at Nanyang Technological University and National University of Singapore, Singapore, and a scientist at TCS Innovation Labs, Delhi. She is the recipient of the Best Ph.D. thesis award (The Seshagiri Kaikini Medal) for 2014- 2015 from the Council of Indian Institute of Science, and the recipient of the Best Paper in the Communications Track at NCC 2014, held at IIT Kanpur.Her current research interests are: Causal Inference, Survival analysis, and sparsity in Bayesian neural networks.',
      'faculty_College':
          '\nPh.D. (2015), Indian Institute of Science, Banglore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/ranjitha.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/ranjitha-prasad-7ab84b30/',
      'faculty_Website_Url': 'https://iiitd.ac.in/ranjitha',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907357"',
      'faculty_Office_Address': '\nB-607 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Causal Inference,Survival analysis, and sparsity in Bayesian neural networks.',
      'faculty_Teaching_Interests':
          'Causal Inference,Survival analysis, and sparsity in Bayesian neural networks.',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/ranjitha',
      'faculty_Website_Page': '/ranjitha',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Franjitha%40iiitd.ac.in%2Franjitha.png?alt=media&token=6f4e7af8-f162-4608-8272-a75d0712a072',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Richa Gupta',
      'faculty_EmailId': 'richa.gupta@iiitd.ac.in',
      'faculty_Department': 'HCD',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Richa Gupta completed Ph.D. from IIT Delhi in 2020. She holds a post-graduate degree in Industrial Design (M.Des.) from IDC, IIT Bombay (2013) and completed B.Tech. in Mechanical Engineering from IIIT Jabalpur (2011). She has done collaborative research at the School of Informatics and Computing, IUPU Indianapolis, USA (2017-18) and TU Darmstadt, Germany (2012). She has also worked as Project Scientist at AssisTech Labs, IIT Delhi where she contributed in design and development of several award winning translational research projects, namely SmartCane Device, DotBook (Braille Laptop for Blind), TacRead, OnBoard Bus Identification System, Accessible Graphics Design, and Multi-Modal Braille Learning Device. She is recipient of several prestigious fellowships namely, Stanford Ignite Global Innovation Fellowship (2015), Visvesvaraya PhD Fellowship (2015), JENESYS Fellowship (Indo-Japan Exchange Program, 2010). She was awarded the Chairman’s Silver Medal for Excellence in Academics at IIIT Jabalpur in 2011. Her current research interests are: Perceptual foundations of Design, Inclusive Design and Accessibility, Product Design & Modern Prototyping, Multi-modal Interaction/Experience Designa',
      'faculty_College': 'Ph.D. (2020), IIT-Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/richagupta.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/richagupta',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907368"',
      'faculty_Office_Address': 'A-406 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Perceptual foundations of Design,Inclusive Design and Accessibility,Metaverse,HCI,Interaction Design,Educational Technologies',
      'faculty_Teaching_Interests':
          'Product Design & Prototyping, Inclusive Design & Accessibility,Design for Special Needs,Fundamentals of Design,Interaction Design',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/richagupta',
      'faculty_Website_Page': '/richagupta',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fricha.gupta%40iiitd.ac.in%2Frichagupta.png?alt=media&token=1491defc-f580-495d-9382-af302bbeeed2',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Rinku Shah',
      'faculty_EmailId': 'rinku@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Rinku Shah earned her Ph.D. degree in Computer Science from IIT Bombay in February 2021. She has worked with Prof. Mythili Vutukuru and Prof. Purushottam Kulkarni at IIT Bombay. During her Ph.D., she interned at VMware for six months towards defining and solving capacity-aware load balancing in data center networks. After her Ph.D., she has spent seven months as a Project Research Scientist on a Huawei project at IIT Bombay with Prof. Umesh Bellur.Her primary research interests lie in the broad area of networked systems, specifically Software-Defined Networking (SDN) and programmable data planes. Her focus is to design data plane algorithms and data structures to build flexible, scalable, and fault-tolerant systems that solve real-world problems. Her research is published at reputed conference venues such as the ACM SOSR, IEEE ICNP, ACM APNet, and the ACM DEBS. She has served as a reviewer for peer-reviewed conferences such as EuroSys (shadow PC member), ICACCI, and INDICON.',
      'faculty_College': 'PhD (2021), IIT Bombay, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/rinku.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/rinku-shah-b2646716/',
      'faculty_Website_Url': 'https://iiitd.ac.in/rinku',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907538"',
      'faculty_Office_Address': '\nB-511 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Software-Defined Networking,Data plane programming,4G/5G mobile networks',
      'faculty_Teaching_Interests': 'Computer networks,Programmable networks',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/rinku',
      'faculty_Website_Page': '/rinku',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Frinku%40iiitd.ac.in%2Frinku.png?alt=media&token=58c324fa-9b56-4583-b987-bb43f173534b',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Saket Anand',
      'faculty_EmailId': 'anands@iiitd.ac.in',
      'faculty_Department': 'ECE, CSE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Saket Anand is an Associate Professor at Indraprastha Institute of Information Technology (IIIT), Delhi. He completed his PhD in Electrical and Computer Engineering from Rutgers University in 2013. He was part of the Robust Image Understanding Lab at Rutgers and his current research interests are design of robust statistical methods for heavily corrupted data, 3D scene reconstruction techniques and semi-supervised clustering methods. From 2007 to 2010, he worked as a research engineer at Read-Ink Technologies, Bangalore, developing algorithms for handwriting recognition. His Masters research carried out at Rutgers (2004-2006) involved design and implementation of face recognition and speech recognition algorithms. He is a member of the IEEE.',
      'faculty_College': 'PhD (2013), Rutgers University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/saket.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/saket-anand-698b98a/',
      'faculty_Website_Url': 'https://iiitd.ac.in/anands',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907425"',
      'faculty_Office_Address': '\nB-410 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Geometric Computer Vision,Semi-supervised learning,Robust methods,Scene understanding',
      'faculty_Teaching_Interests':
          'Computer Vision,Statistical Signal Processing,Machine Learning,Linear optimization',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/anands',
      'faculty_Website_Page': '/anands',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fanands%40iiitd.ac.in%2Fanands.png?alt=media&token=c179f62b-cc31-4e01-b099-07e29640abe4',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sambuddho Chakravarty',
      'faculty_EmailId': 'sambuddho@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Sambuddho Chakravarty completed his Ph.D. in Computer Science from Columbia University in 2014. He was advised by Prof. Angelos D. Keromytis. His research focuses on Network Anonymity and Privacy, Network Surveillance and Anti-Censorship and Network and Distributed Systems Security in general. During his Ph.D. he studied novel practical traffic analysis vulnerabilities of popular anonymity networks like Tor. He has served an intern at Telcordia Applied Research, New Jersey and Force 10 Networks, California.',
      'faculty_College': 'PhD (2014), Columbia University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/sambuddho.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/schakravarty-iiitd/',
      'faculty_Website_Url': 'https://iiitd.ac.in/sambuddho',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907478"',
      'faculty_Office_Address': '\nB-503 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Network Anonymity and Privacy,Network Censorship and Anti-Censorship,Network and Systems Security',
      'faculty_Teaching_Interests':
          'Network Anonymity and Privacy (NAP 7XX),Network Security,Host/Systems Security,OS,Computer Network',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sambuddho',
      'faculty_Website_Page': '/sambuddho',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsambuddho%40iiitd.ac.in%2Fsambuddho.png?alt=media&token=fe3f7b70-8010-499d-a575-97632b2aaead',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Samrith Ram',
      'faculty_EmailId': 'samrith@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "He was a Postdoctoral Researcher at the Harish-Chandra Research Institute, Allahabad. Originally from an engineering background, he received his B.Tech. in Electrical Engineering from IIT Madras in 2003. He later completed his Ph.D. as an NBHM fellow in the Department of Mathematics, IIT Bombay in 2012. He was awarded the 'Excellence in Thesis' award for his Ph.D. thesis by IIT Bombay. He was also the recipient of the Archimedes Postdoctoral Fellowship awarded by the Marseille Institute for Mathematics and Computer Science, Marseille, France in 2013. His primary research interests include Finite Fields and Combinatorics.",
      'faculty_College': 'Ph.D. (2012), Department of Mathematics, IIT Bombay',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/samrithram.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/samrithram',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907472"',
      'faculty_Office_Address': 'B-305 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': 'Finite Fields and Combinatorics',
      'faculty_Teaching_Interests': 'Finite Fields and Combinatorics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/samrithram',
      'faculty_Website_Page': '/samrithram',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsamrith%40iiitd.ac.in%2Fsamrithram.png?alt=media&token=8dc6837d-6ac1-4447-ad68-1ca27128f478',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sanat K Biswas',
      'faculty_EmailId': 'sanat@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Sanat holds PhD (2017) in space vehicle navigation from the University of New South Wales, M. Tech (2012) in Aerospace Engineering from IIT Bombay and B.E. (2010) in Instrumentation and Electronics Engineering from Jadavpur University. Sanat's research interests include space vehicle guidance, navigation and control, orbit determination, GNSS-based navigation, non-linear dynamics and estimation algorithms. Sanat was associated with the Australian Centre for Space Engineering Research, where he did his PhD research. He also participated in the development of a nano satellite, UNSW-EC0 which was recently launched into a Low Earth Orbit. He received 2014 Emerging Space Leaders' Grant from the International Astronautical Federation for his research contribution in space engineering.",
      'faculty_College':
          '\nPhD(2017), Space Vehicle Navigation, The University of New South Wales',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/sanatk.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/sanat-biswas/',
      'faculty_Website_Url': 'https://iiitd.ac.in/sanat',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907439"',
      'faculty_Office_Address': '\nB-602 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Space vehicle guidance,Navigation and control,Orbit determination,GNSS-based navigation, non-linear dynamics and estimation algorithms',
      'faculty_Teaching_Interests':
          'Circuits and Signals,Digital Signal Processing,Linear Control System and State Space Methods,Optimal Control and Estimation,Global Navigation Satellite System (GNSS)',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sanat',
      'faculty_Website_Page': '/sanat',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsanat%40iiitd.ac.in%2Fsanat.png?alt=media&token=548e5578-5097-48a7-8fbd-25c7cc9ea22a',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sanjit Krishnan Kaul',
      'faculty_EmailId': 'skkaul@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Sanjit K. Kaul received the B.Tech. degree in electronics and communications engineering from the Birla Institute of Technology, Mesra, in 2000 and the Ph.D. degree in electrical and computer engineering from Rutgers University in 2011. Year 2000 onwards, he worked in the telecommunications industry for four years. He was a Research Assistant with the Wireless Information Networks Laboratory from 2005 to 2011. He is currently an Associate Professor with IIIT-Delhi. He works on problems in wireless systems research. His current interests include age-of-information, networking for cyber-physical systems, networks of autonomous vehicles, and autonomous driving.',
      'faculty_College':
          '\nPhD (2011), Electrical and Computer Engineering, Rutgers University, USA',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/sanjit.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/skkaul',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907457"',
      'faculty_Office_Address': '\nB-411 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Age-of-Information,Networking for Cyber Physical Systems,Networks of Autonomous Vehicles, and Autonomous Driving',
      'faculty_Teaching_Interests':
          'Probability and Random Processes,Wireless Networks,Reinforcement Learning',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/skkaul',
      'faculty_Website_Page': '/skkaul',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fskkaul%40iiitd.ac.in%2Fskkaul.png?alt=media&token=ef61b053-abb0-4e24-a384-f00d305575c7',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sankha S Basu',
      'faculty_EmailId': 'sankha@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'He has obtained his Ph.D. in Mathematics from The Pennsylvania State University in 2013, and an M.S. in Mathematics from Marquette University in 2008. His area of research is Mathematical Logic. More specifically, his area of interest is in non-classical logics, such as intuitionistic logic and paraconsistent logics. His Ph.D. dissertation links intuitionistic logic with computability theory via a model for higher-order intuitionistic logic that is based on the Turing degrees. Before joining IIIT-Delhi, he worked as faculty at The Pennsylvania State University, the University of Tennessee at Chattanooga, and Middle Tennessee State University.',
      'faculty_College':
          '\nPh.D. (2013), Mathematics from The Pennsylvania State University',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/sankhasbasu.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/sankha',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907489"',
      'faculty_Office_Address': '\nB-306 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Mathematical Logic - intuitionistic logic and paraconsistent logics',
      'faculty_Teaching_Interests': 'Mathematical Logic',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sankha',
      'faculty_Website_Page': '/sankha',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsankha%40iiitd.ac.in%2Fsankha.png?alt=media&token=ea58c2eb-c359-4674-abd1-b98d86b9d024',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sarthok Sircar',
      'faculty_EmailId': 'sarthok@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Sarthok Sircar was a Lecturer- School of Mathematical Sciences at the Adelaide University-Australia. He has completed his PhD in 2009 in Applied Mathematics from University of South Carolina followed by postdoctoral fellowships in University of Colorado and University of Utah in USA. In the past 12 years of his scholastic work in the field of Applied Mathematics, he has applied multi-scale modeling, numerical simulations and experimental design to solve complex problems viz. dynamics and rheology of active gel systems, bacterial swarming and aggregation, swelling kinetics of ionic gels and liquid crystals polymers. His research work has been published in the form of peer reviewed journal articles (25), book chapters (1), guest lectures (20) and conference proceedings (1). His work has obtained 300+ citations with h-index of 10 and i-index of 10. He has taught courses in Calculus, Differential Equations, Linear Algebra, Calculus of Variations, Optimization and Mathematical Biology.',
      'faculty_College':
          '\nPhD (2009) in Applied Mathematics from University of South Carolina',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/sarthoks.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/sarthok',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907435"',
      'faculty_Office_Address': '\nB-303 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Developing multiscale models and robust numerical algorithms for complex systems,Fluid Mechanics,Aymptotics and perturbations',
      'faculty_Teaching_Interests':
          'Integral Transforms and Fractional Calculus,Variational calculus and their applications,Multivariate Calculus,Variational Calculus,Fractional Calculus,Approximation theory',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sarthok',
      'faculty_Website_Page': '/sarthok',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsarthok%40iiitd.ac.in%2Fsarthok.png?alt=media&token=b301b15c-7828-4688-889a-2c73a68b6ec8',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Satish Kumar Pandey',
      'faculty_EmailId': 'satish@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': 'Center for Quantum Technologies',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Satish Kumar Pandey earned his Ph.D. in Pure Mathematics in 2018 from University of Waterloo under the supervision of Vern Paulsen. He obtained his MS in Applied Mathematics from University of Houston in 2012. Prior to joining IIIT-Delhi, he was a PBC postdoctoral research fellow in the Faculty of Mathematics at Technion-Israel Institute of Technology (2018-21), working with Orr Shalit. His research interests lie primarily in functional analysis. In particular, he is interested in operator theory (univariate and multivariate), operator algebras, reproducing kernel Hilbert spaces, and quantum information theory (QIT). His research work can be broadly categorized into two parts: operator theory/operator algebras and their techniques in QIT. In addition to these, he is also investigating the application of reproducing kernel Hilbert space techniques in QIT.',
      'faculty_College': '\nPh.D. (2018), University of Waterloo, Canada',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/satish.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/satish',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907369"',
      'faculty_Office_Address': 'A-206 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Operator theory (univariate and multivariate),Operator algebras,Reproducing kernel Hilbert spaces,Quantum information theory',
      'faculty_Teaching_Interests':
          '(Advanced) Linear algebra,Point-set topology,Real and complex analysis,Functional analysis,Quantum information theory,Reproducing kernel Hilbert spaces',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/satish',
      'faculty_Website_Page': '/satish',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsatish%40iiitd.ac.in%2Fsatish.png?alt=media&token=3b36a0af-5e62-475d-b138-f509c0476fff',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sayak Bhattacharya',
      'faculty_EmailId': 'sayak@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Sayak Bhattacharya obtained his PhD from Dept. of Electrical Engineering, IIT Delhi in 2016. Before joining IIIT Delhi, he was appointed as a Postdoctoral Fellow in Prof. Sajeev John’s group at the University of Toronto since 2016. His current research focus is light-trapping and energy harvesting in ultra-thin, flexible, silicon photonic crystal solar cells. His broad area of interest is designing semiconductor devices that rely on photonic crystal mediated strong light-matter interaction. He is the recipient of SPIE Best Student Paper Award in the 12th International Conference on Fiber Optics and Photonics, 2014. His paper (co-authored with Prof. John), “Designing High-Efficiency Thin Silicon Solar Cells Using Parabolic-Pore Photonic Crystals", has been featured as Editor’s Suggestion in the April, 2018 issue of Physical Review Applied for illustrating a roadmap towards 28−29% conversion efficiency (well beyond the current world-record efficiency of 26.7%) in silicon solar cells. He has served as a reviewer for Renewable & Sustainable Energy Reviews.',
      'faculty_College': 'PhD (2016), IIT Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/sayakbhatt.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/sayak',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907356"',
      'faculty_Office_Address': '\nB-603 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Ultra-thin and high-efficiency photovoltaics,Strong light-matter interaction in photonic crystals',
      'faculty_Teaching_Interests': 'Electromagnetics,Photonics,Quantum Optics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sayak',
      'faculty_Website_Page': '/sayak',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsayak%40iiitd.ac.in%2Fsayak.png?alt=media&token=b7b1b43d-e27b-4651-9abb-8196d7fe1109',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sayan Basu Roy',
      'faculty_EmailId': 'sayan@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "Sayan has obtained his bachelor's degree in Electronics and Tele-Communication Engineering from Jadavpur University, West Bengal in the year of 2014. Subsequently, he has completed his PhD from the control and automation group of Electrical Engineering at Indian Institute of Technology Delhi (January 2015-February 2019). He is working as an Assistant Professor at the Electronics and Communication Engineering Department of Indraprastha Institute of Information Technology Delhi since September 2018. His research on the broad area of nonlinear and adaptive control has got recognition in top-tier journals and conferences of IEEE control systems society. He serves as a reviewer of several reputed journals and conferences including IEEE transactions on Automatic Control, Automatica, IEEE transactions on Neural Network and Learning Systems, International Journal of Adaptive Control and Signal Processing, IEEE Conference on Decision and Control, American Control Conference etc. His current research interest includes adaptive control for uncertain switched systems, online approximate optimal control using reinforcement learning based solutions, adaptive backstepping control and its variants, cooperative control of multi-agent systems, differential games, adaptive extremum seeking control, passivity-based control applications to under-actuated robotics, etc.",
      'faculty_College': 'PhD (2019), IIT-Delhi',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/sayan.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/sayan-basu-roy-680a9067/',
      'faculty_Website_Url': 'https://iiitd.ac.in/sayan',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907559"',
      'faculty_Office_Address': '\nA-603 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Adaptive control for uncertain switched systems,Online approximate optimal control using reinforcement learning based solutions,Adaptive backstepping control',
      'faculty_Teaching_Interests':
          'Control Systems,Robotics,Adaptive and Learning Control',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sayan',
      'faculty_Website_Page': '/sayan',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsayan%40iiitd.ac.in%2Fsayan.png?alt=media&token=9678b16b-4cfc-4f7e-8f2e-8cce50fcda8c',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Shobha Sundar Ram',
      'faculty_EmailId': 'shobha@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Shobha Sundar Ram received her B.Tech. degree in electronic and communication engineering from University of Madras in 2004, and her M.S and Ph.D. degrees in electrical engineering from University of Texas at Austin in Austin, Texas, USA in 2006 and 2009,respectively. She worked for 3 years as a research and development electrical engineer for Baker Hughes Inc., in Houston, Texas, USA. She joined the faculty of Indraprastha Institute of Information Technology, New Delhi in January 2013.',
      'faculty_College':
          '\nPhD (2009), Electrical Engineering, University of Texas at Austin',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/shobha.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/shobha',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907460"',
      'faculty_Office_Address': 'B-606 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Conceptualize Model Design and Test Electromagnetic Sensors for Following Applications - Through-wall radar sensing of humans,EMI based sensing of energy consumption in buildings, On-chip wireless interconnects',
      'faculty_Teaching_Interests':
          'Antennas and Wave Propagation,Linear Circuits,Radar Systems,Engineering Electromagnetics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/shobha',
      'faculty_Website_Page': '/shobha',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fshobha%40iiitd.ac.in%2Fshobha.png?alt=media&token=0801288d-d8f9-4b59-9dc1-6781a4c87135',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Smriti Singh',
      'faculty_EmailId': 'smriti@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Smriti Singh has completed her PhD from the Jawaharlal Nehru University, New Delhi in 2017. She has been interested in the broad area of Urban Sociology and Social Class. She has earned her M.Phil. and Postgraduate degree from Jawaharlal Nehru University, New Delhi and her Undergraduate degree from Lady Shri Ram College for Women, Delhi University. She is a Nehru-Fulbright Doctoral Scholar, 2015-2016 to University of Michigan, Ann Arbor, Michigan. She has previously taught at Ambedkar University, Delhi; Azim Premji University, Bengaluru; and Lady Shri Ram College for Women, Delhi University. She has been UNICEF-KCCI intern, 2009 and has worked briefly with Katha, New Delhi and Butterflies, New Delhi. She has presented at various national and international conferences and has periodically endured the heartache of editorial and peer review. Her current research interest is in the broad areas of social media, information technology and urban middle class; virtual community and solidarity and; privacy, surveillance and technology. She prides herself in being a learner and an educator and is always psyched at the prospect of research suggestions and discussions over copious cups of tea-coffee.',
      'faculty_College': '\nPhD (2017), Jawaharlal Nehru University, New Delhi',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/smriti.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/smriti',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907361"',
      'faculty_Office_Address': 'B-211 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Social Class, Gender, Urban Space and Community,Neo-Urban, Spatial Sociology,Virtual Community and Solidarity,Digital Childhood and Parenting',
      'faculty_Teaching_Interests':
          'Gender and Intersectionality,Social Stratification,Sociology of India,Gender and Media,Sociological Theory,Urban Sociology',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/smriti',
      'faculty_Website_Page': '/smriti',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsmriti%40iiitd.ac.in%2Fsmriti.png?alt=media&token=6091ee0f-a844-4de0-905f-6fac3737378b',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sneh Saurabh',
      'faculty_EmailId': 'sneh@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Sneh Saurabh obtained his Ph.D. from IIT Delhi in 2012 and B.Tech. (EE) from IIT Kharagpur in the year 2000. He has rich experience in the semiconductor industry, having spent 16 years working for industry leaders such as Cadence Design Systems, Synopsys India, and Magma Design Automation. He has been involved in developing some of the well-established industry-standard EDA tools for clock synchronization, constraints management, STA, formal verification, and physical design. He has been teaching semiconductor-specific courses since 2016 at IIIT Delhi. His teaching has been rated excellent by students consistently, and he has received the Teaching Excellence award for seven consecutive semesters at IIITD. His current research interests are in the areas of VLSI Design and Automation, Energy-Efficient Systems, and Stochastic Computational Frameworks. He is the author of the books “Introduction to VLSI Design Flow” and “Fundamentals of Tunnel Field-Effect Transistors” and holds three US patents. He is an Editor (IETE Technical Review), an Associate Editor (IEEE Access), a Review Editor (Frontiers in Electronics Integrated Circuits and VLSI), and a Senior Member of IEEE.',
      'faculty_College': '\nPhD (2012), Electrical Engineering, IIT, Delhi',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/sneh.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/snehsaurabh/',
      'faculty_Website_Url': 'https://iiitd.ac.in/sneh',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907456"',
      'faculty_Office_Address': '\nB-608 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'VLSI Design and Automation,Energy-Efficient Systems,Nanoelectronics,Stochastic Computational Frameworks',
      'faculty_Teaching_Interests':
          'VLSI Design Flow,CAD for VLSI,Semiconductor Devices,Nanoelectronics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sneh',
      'faculty_Website_Page': '/sneh',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsneh%40iiitd.ac.in%2Fsneh.png?alt=media&token=35261e64-3167-494f-8ca3-b3802041a3a5',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sneha Chaubey',
      'faculty_EmailId': 'sneha@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Sneha is PhD from University of Illinois at Urbana-Champaign (UIUC) advised by Prof. Alexandru Zaharescu. She has held Postdoctoral position at the Mathematische Institut, University of Gottingen, Germany. Before joining UIUC she was at NISER, Bhubaneswar where she completed her Integrated BS and MS in mathematics. Her research interests lies in number theory and its interactions with geometry and dynamics. She is especially interested in analytic number theory, distribution of sequences and their spacing statistics using level spacing and correlation measures, zeros of Riemann zeta function and L-functions, and exponential sums.',
      'faculty_College':
          '\nPhD 2017 University of Illinois at Urbana-Champaign (UIUC)',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/sneha.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/sneha',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907462"',
      'faculty_Office_Address': '\nB-308 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Number theory and its interactions with geometry and dynamics',
      'faculty_Teaching_Interests':
          'Analytic number theory, distribution of sequences and their spacing statistics using level spacing and correlation measures, zeros of Riemann zeta function and L-functions, and exponential sums',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sneha',
      'faculty_Website_Page': '/sneha',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsneha%40iiitd.ac.in%2Fsneha.png?alt=media&token=cf5ccfdd-6c2d-4c1f-8190-eaa8d37e7f7b',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sonia Baloni Ray',
      'faculty_EmailId': 'sonia@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Sonia Baloni Ray is a Ph.D. degree holder from German Primate Center, Georg August University, Goettingen, Germany in 2012. She did her post-doctoral research at Centre of Behavioural and Cognitive Science, University of Allahabad. During her post-doctoral tenure she received DST-CSRI (Department of Science and Technology, Govt. Of India- Cognitive Science Research Initiative) fellowship. She is interested in studying the mechanisms of attention that are involved in the processing of visual information in our surrounding. She has experience in psychophysics, EEG and eye-tracking methodologies.',
      'faculty_College':
          '\nPh.D. (2012), Georg August University, Goettingen, Germany',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/sonia.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/sonia-baloni-ray-294763a4/',
      'faculty_Website_Url': 'https://iiitd.ac.in/sonia',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907424"',
      'faculty_Office_Address': '\nB-210 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Role of attention in visual processing, studying mechanisms of emotion and motion perception',
      'faculty_Teaching_Interests':
          'Attention and Perception,Cognition of Motor movement Computational models of cognition',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sonia',
      'faculty_Website_Page': '/sonia',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsonia%40iiitd.ac.in%2Fsonia.png?alt=media&token=137e2adf-9f6f-4263-b84e-8ad227ffa3b9',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Souvik Dutta',
      'faculty_EmailId': 'souvik@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Souvik Dutta completed his Ph.D. in Economics from Pennsylvania State University in 2014. He uses both analytical modelling and econometrics in his research. Some of his current areas of interest are in the fields of political economy, microfinance and economics of digital marketing. He has received several research grants from International Growth Centre (IGC), EfD and Centre for Development Economics and Sustainability (CDES). Before his Ph.D, Souvik obtained his masters degree in economics from Delhi School of Economics and his undergraduate degree in economics from Presidency College, Kolkata. Before joining IIIT-D, Souvik was a faculty at Indian Institute of Management, Bangalore.',
      'faculty_College': 'PhD (2014), Pennsylvania State University',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/souvik.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/souvik-dutta-a4b7463b/',
      'faculty_Website_Url': 'https://iiitd.ac.in/souvik',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907536"',
      'faculty_Office_Address': '\nB-203 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Political economy, microfinance and economics of digital marketing',
      'faculty_Teaching_Interests':
          'Microeconomics,Political Economy,Development Economics,Information Economics',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/souvik',
      'faculty_Website_Page': '/souvik',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsouvik%40iiitd.ac.in%2Fsouvik.png?alt=media&token=0bc47196-f751-4455-87c3-aa8861745fbb',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sriram K',
      'faculty_EmailId': 'sriramk@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'I got my Ph.D. from IIT-Madras in 2004, and then went on to do my post-doc in various places that includes a two year stint in INRIA, Rocquencourt, France, and at UCSB, USA. My general research interests are systems biology and dynamical system analysis of neuronal models. Presently, I am interested in understanding learning and memory in both Post-traumatic Stress Disorder (PTSD) and depression from systems biology perspective. Besides, my interests also revolves around mathematical modeling of circadian rhythms, cell division cycle, and understanding of biological network dynamics.',
      'faculty_College': '\nPh.D. (2004), Chemistry, IIT Madras',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/sriram.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/sriram',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907436"',
      'faculty_Office_Address': 'A-308 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Systems biology,Cell division cycle,Circadian rhythms,Computational cognitive neuroscience',
      'faculty_Teaching_Interests':
          'Cell biology and Biochemistry,Systems biology,Computational neuroscience.',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sriram',
      'faculty_Website_Page': '/sriram',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsriramk%40iiitd.ac.in%2Fsriram.png?alt=media&token=b2cc3089-13cf-4e7b-9a6d-905055891ebf',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Subhabrata Samajder',
      'faculty_EmailId': 'subhabrata@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Subhabrata has done his PhD in Computer Science from Indian Statistical Institute, Kolkata in 2017. Previously he has worked at R. C. Bose Center for Cryptology and Security, Indian Statistical Institute, Kolkata and at Turing Lab, Applied Statistics Unit, Indian Statistical Institute, Kolkata. He was also associated with the Mathematics Department of Presidency University, Kolkata. He has done his Bachelor of Science (with Honours) in Mathematics from Presidency College, Kolkata and Master of Science in Mathematics from Indian Institute of Technology, Kharagpur. Followed by Master of Technology (with Honours) in Computer Science from Indian Statistical Institute, Kolkata. Having had his formative training in Mathematics, Statistics and Computer Science, he feels comfortable working on real-life problems which lie at the juncture of these three broad areas.',
      'faculty_College': 'PhD (2017) Indian Statistical Institute, Kolkata',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/subhabrata.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/subhabrata-samajder-10138318/',
      'faculty_Website_Url': 'https://iiitd.ac.in/subhabrata',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907370"',
      'faculty_Office_Address': 'A-510 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Symmetric-key Cryptanalysis,Lattice-based cryptography,Blockchains and random graphs',
      'faculty_Teaching_Interests':
          'Cryptography,Probability and Statistics,Data Structures and Algorithms,Design and Analysis of Algorithms',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/subhabrata',
      'faculty_Website_Page': '/subhabrata',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsubhabrata%40iiitd.ac.in%2Fsubhabrata.png?alt=media&token=7ad042b9-c4ec-454e-abd5-ed8eb5cf7585',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Subhashree Mohapatra',
      'faculty_EmailId': 'subhashree@iiitd.ac.in',
      'faculty_Department': 'Math',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Subhashree Mohapatra obtained her Ph.D. in Applied Mathematics from Indian Institute of Technology Kanpur, India in 2013. Prior to joining IIIT-Delhi, she worked as an Assistant Professor at SRM University A.P., India. She has four years of Post-doctoral experience at IIT Bhubaneswar, IISc. Bangalore (NBHM Post-doctoral fellowship: Spectral element method for Stokes and Navier-Stokes equations), University of Florida, Gainesville (Optimal control theory) and UTHSC San Antonio USA (Software development for PDEs related to Biophysics applications). Her primary research interests include development of high order efficient schemes for numerical solutions of differential equations, their implementation on parallel machines and optimization problems with differential equations as constraints. She has served as a reviewer for the journal IEEE Transactions on Automatic Control.',
      'faculty_College': '\nPhD (2013), IIT Kanpur',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/subhashreem.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/subhashreem',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907459"',
      'faculty_Office_Address': '\nA-309 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'High order schemes for numerical solution of partial differential equations,Optimal control theory,Parallel implementation of computational fluid dynamics related problems',
      'faculty_Teaching_Interests':
          'High order schemes for numerical solution of partial differential equations,Optimal control theory,Parallel implementation of computational fluid dynamics related problems',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/subhashreem',
      'faculty_Website_Page': '/subhashreem',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsubhashree%40iiitd.ac.in%2Fsubhashreem.png?alt=media&token=8d7c174c-297c-43b7-9f15-2c27a535e27e',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sujay Deb',
      'faculty_EmailId': 'sdeb@iiitd.ac.in',
      'faculty_Department': 'ECE, CSE',
      'faculty_Position': 'Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Sujay Deb is a Professor in Electronics & Communication Engineering and Computer Science & Engineering at Indraprastha Institute of Information Technology, Delhi (IIIT-D). He received Ph.D. from the School of Electrical Engineering and Computer Science, Washington State University, Pullman, WA on May 2012. Before his current position, he worked as an intern at Intel Labs, Hillsboro, OR. His major awards and achievements include DST INSPIRE Faculty award in 2012; Outstanding Ph.D. student award in Computer Engineering, WSU, 2011; Winner of India-US Grand Challenge Initiative for Affordable Blood Pressure measurement technologies in 2014.',
      'faculty_College': 'PhD (2012), Washington State University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/sdeb.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/debsujay/',
      'faculty_Website_Url': 'https://iiitd.ac.in/sdeb',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907452"',
      'faculty_Office_Address': '\nA-607 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Heterogeneous System Architectures (HSA),SoC Design & Test,Design of novel interconnect architectures for multi-core chips,Hardware Security,Low-cost bio-sensors for preventive healthcare',
      'faculty_Teaching_Interests':
          'Computer Organization,Computer Architecture,SoC Design & Test,Digital VLSI Design',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sdeb',
      'faculty_Website_Page': '/sdeb',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsdeb%40iiitd.ac.in%2Fsdeb.png?alt=media&token=1c84b3f0-a885-45b6-bbd5-4e2d3fe59e2d',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Sumit J Darak',
      'faculty_EmailId': 'sumit@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Sumit J. Darak received his Bachelor of Engineering (B.E.) degree in Electronics and Telecommunications Engineering from Pune University, India in 2007, and PhD degree from the School of Computer Engineering, Nanyang Technological University (NTU), Singapore in 2013.He is currently an Associate Professor at Indraprastha Institute of Information Technology, Delhi, India. Prior to that, he was working as Assistant System Engineer in Tata Consultancy Services (TCS), Pune, India from September 2007 to December 2008. From August 2011 to November 2011, he was visiting research student at Massey University, Auckland, New Zealand. From August 2012 to January 2013, he worked as an intern at EADS Innovation Works (Airbus), Singapore. From March 2013 to November 2014, he was pursuing postdoctoral research at the CominLabs Excellence Center, Université Europèenne de Bretagne (UEB) and Supélec, Rennes, France for the project GREAT: Green Cognitive Radio for Energy-Aware Wireless Communication Technologies Evolution. Dr. Sumit has been awarded India Government’s ‘DST Inspire Faculty Award’ which is a prestigious award for young researchers under 32 years age. His research interests include design and implementation of multistandard wireless communication receivers as well as application of machine learning algorithms and decision making policies for various wireless communication applications.',
      'faculty_College':
          'PhD (2013), Nanyang Technological University (NTU), Singapore',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/sumit.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/sumitdarak/',
      'faculty_Website_Url': 'https://iiitd.ac.in/sumit',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907427"',
      'faculty_Office_Address': '\nB-605 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Intelligent, Reconfigurable and Self-sustainable wireless radio,Machine learning for wireless networks,Algorithms to architectures',
      'faculty_Teaching_Interests':
          'Green Information and Communication Technology,Advanced digital system design,Advanced digital signal processing',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/sumit',
      'faculty_Website_Page': '/sumit',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsumit%40iiitd.ac.in%2Fsumit.png?alt=media&token=dcefec4b-d9f5-4d70-aaa6-6c9543ae2c94',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Syamantak Das',
      'faculty_EmailId': 'syamantak@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor ',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Syamantak obtained his Ph.D. from IIT Delhi. He spent 9 months after that as a visiting postdoc at the Max Planck Institute for Informatik, Germany and subsequently another year as a postdoc at the University of Bremen, Germany.His primary research interests lie at the intersection of theoretical computer science and discrete optimization. In particular, he is currently interested in designing approximation and online algorithms for various kinds of combinatorial optimization problems, for example, scheduling, network design.',
      'faculty_College': 'PhD (2015), IIT-Delhi, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/syamantak.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/syamantak-das-aa227021b/',
      'faculty_Website_Url': 'https://iiitd.ac.in/syamantak',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907529"',
      'faculty_Office_Address': '\nB-512, (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Intersection of theoretical computer science and discrete optimization',
      'faculty_Teaching_Interests':
          'Intersection of theoretical computer science and discrete optimization',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/syamantak',
      'faculty_Website_Page': '/syamantak',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fsyamantak%40iiitd.ac.in%2Fsyamantak.png?alt=media&token=9cb81d5a-ead0-425c-963d-a0d998eca4d0',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Tammam Tillo',
      'faculty_EmailId': 'tammam@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "In 1994 he received the Engineer Diploma in electrical engineering from University of Damascus, Syria.In 2005 he received the Ph.D. degree in electronics and communication engineering from Politecnico di Torino, Italy.In 2004, for some months, he was a visiting research student at Ecole Polytechnique Fèdèrale de Lausanne, Switzerland. In a period of time from 2005 to 2008 he worked with a group named image processing lab at Politecnico di Torino. In 2008, for around two months, he joined a group named digital media lab at SungKyunKwan University, Republic of Korea. In 2008 he joined Xi'an Jiaotong-Liverpool University, China. In 2017 he joined Free University of Bozen-Bolzano, Italy.In 2021 he joined Indraprastha Institute of Information Technology-Delhi",
      'faculty_College': 'PhD (2005), Politecnico di Torino, Italy',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/tammam.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/tammam',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907366"',
      'faculty_Office_Address': '\nA-602 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Convolutional Neural Networks for some image processing tasks',
      'faculty_Teaching_Interests':
          'Convolutional Neural Networks, Image Processing, Signal Processing',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/tammam',
      'faculty_Website_Page': '/tammam',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Ftammam%40iiitd.ac.in%2Ftammam.png?alt=media&token=d7045962-2adc-4fd0-9736-c5a80f3dc462',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Tanmoy Chakraborty',
      'faculty_EmailId': 'tanmoy@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Infosys Centre for Artificial Intelligence (CAI)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          "He completed his Ph.D as a Google India Ph.D. fellow in the Dept. of CSE, IIT Kharagpur, India in Sept, 2015. Afterwards, he spent around one and half years at University of Maryland, College Park, USA as a postdoctoral researcher. His Ph.D. thesis has been recognized as the best Ph.D. thesis by Xerox Research India and IBM Research India. He has also received INAE doctoral level innovation student project award, best paper runner up in ASONAM'16, best poster award in Microsoft TechVista'15. He has been awarded prestigious Ramanujan Faculty Fellowship and DAAD Faculty Award. His primary research interests include Network Science, Data Mining, Natural Language Processing and Data-driven cybersecurity. He has served as a PC member in various top conferences including WWW, AAAI, PAKDD, IJCAI, and reviewer of top journals including ACM TKDD, IEEE TKDE, ACM TIST, CACM. He is also co-organizer of three workshops – TextGraphs-10 (NAACL'16) and SMERP (ECIR'17, WWW'18) and a co-editor of a special issue in Information System Frontiers.",
      'faculty_College': 'PhD (2015), IIT Kharagpur, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/tanmoy.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/tanmoy',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907466"',
      'faculty_Office_Address': '\nB-407 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Network Science, Data Mining and Data-driven Cybersecurity, Natural Language Processing',
      'faculty_Teaching_Interests':
          'Machine Learning, Social Computing, Complex Networks, Speech and Natural Language Processing',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/tanmoy',
      'faculty_Website_Page': '/tanmoy',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Ftanmoy%40iiitd.ac.in%2Ftanmoy.png?alt=media&token=16cf4c04-743f-4b56-b11f-4fe59f9fde28',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Tarini Shankar Ghosh',
      'faculty_EmailId': 'tarini.ghosh@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Tarini Shankar Ghosh is a computational biologist focusing on human microbiome research. He received his B.Tech from Indian Institute of Technology (IIT) Kharagpur, his M.Tech from IIT Kanpur and his Ph.D from the University of Hyderabad (while working at the TCS Innovation Labs of Tata Consultancy Services Ltd). After completing his PhD, he first worked at the Genome Institute of Singapore (as a post-doctoral researcher) and at the APC Microbiome Ireland at Cork as a senior post-doctoral scientist. He has published more than 50 research papers in notable journals including Nature Medicine, Nature Ecology and Evolution, Gut, Gastroenterology and Nature Reviews Gastroenterology and Hepatology. He is a recipient of the Yakult Young Investigator Award in 2014 and the Torrent ISHR Young Investigator in 2017 and was selected for the Pathway Investigator grant awarded by the Science Foundation Ireland and Irish Research Council. He is also an author of multiple US/EU based patents, primarily pertaining to efficient metagenome-informatics algorithms and identification of putatively therapeutic novel microbial consortia targeting frailty and colorectal cancer.',
      'faculty_College': '\nPh.D. (2014), University of Hyderabad, India',
      'faculty_Image_Url': 'https://iiitd.ac.in/sites/default/files/tarini.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/dr-tarini-shankar-ghosh-3b211868/',
      'faculty_Website_Url': 'https://iiitd.ac.in/tarini',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907375"',
      'faculty_Office_Address': '\nA-312 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Integrated multi-OMICs, metagenome informatics, machine learning and statistical learning',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/tarini',
      'faculty_Website_Page': '/tarini',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Ftarini.ghosh%40iiitd.ac.in%2Ftarini.png?alt=media&token=89dfc097-da99-44f9-991e-203a54a81af3',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Tavpritesh Sethi',
      'faculty_EmailId': 'tavpriteshsethi@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Tavpritesh Sethi is a physician-scientist and Associate Professor of Computational Biology at Indraprastha Institute of Information Technology Delhi, India and a fellow of the Wellcome Trust/DBT India Alliance at All India Institute of Medical Sciences, New Delhi, India. Over the past two years, he has been a visiting faculty member at Stanford University, School of Medicine from February 2017 to January 2019. He received his M.B.B.S from Government Medical College, Amritsar and PhD from CSIR-Institute of Genomics and Integrative Biology, New Delhi, India. Dr. Sethi specializes in improving outcomes in neonatal, child and maternal health by bridging medicine and artificial intelligence. His research is focused on development and deployment of machine-learning based solutions to enable decisions and policy in pressing healthcare questions such as antimicrobial resistance, sepsis and health inequalities in intensive care and public health settings. He has authored over 20 research articles and has been a recipient of MIT-TR35 India Innovators under 35, Wellcome Trust/DBT India Alliance Early Career Award. He is an editorial board member of PLOS One, Systems Medicine and Journal of Genetics. Dr. Sethi is a member of the European Association of Systems Medicine and leads the Australasia region for International Association of Systems and Networks Medicine (IASyM).',
      'faculty_College':
          '\nPh.D. from CSIR-Institute of Genomics and Integrative Biology, Delhi',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/tavpritesh.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/tavpritesh/',
      'faculty_Website_Url': 'https://iiitd.ac.in/tavpritesh',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907533"',
      'faculty_Office_Address': 'A-309 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Big-data for clinical decision support, Machine learning for critical care and community medicine, Human physiology and Teaching Interests are Statistical, Complex networks and machine learning modelling for medicine and biology, Human physiology.',
      'faculty_Teaching_Interests':
          'Bridging human physiology and computation for next-generation medicine',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/tavpritesh',
      'faculty_Website_Page': '/tavpritesh',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Ftavpriteshsethi%40iiitd.ac.in%2Ftavpritesh.png?alt=media&token=720a49ef-1ccc-41dd-8469-b1bcca88f733',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'V. Raghava Mutharaju',
      'faculty_EmailId': 'raghava.mutharaju@iiitd.ac.in\n',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Raghava Mutharaju is an Assistant Professor in the Computer Science and Engineering department of IIIT-Delhi, India and leads the Knowledgeable Computing and Reasoning (KRaCR; pronounced as cracker) Lab. He got his Ph.D. in Computer Science and Engineering from Wright State University, Dayton, OH, USA, in 2016. He has worked in Industry research labs such as GE Research, IBM Research, Bell Labs, and Xerox Research. His research interest is in Semantic Web and in general in Knowledge Representation and Reasoning. This includes knowledge graphs, ontology modelling, reasoning, querying, and its applications. He has published at several venues such as ISWC, ESWC, ECAI, and WISE. He has co-organized workshops at ISWC 2020, WWW 2019, WebSci 2017, ISWC 2015 and tutorials at ISWC 2019, IJCAI 2016, AAAI 2015 and ISWC 2014. He is/has been on the Program Committee of several (Semantic) Web conferences such as AAAI, WWW, ISWC, ESWC, CIKM, K-CAP and SEMANTiCS. ',
      'faculty_College': 'PhD (2016), Wright State University, USA',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/raghavam.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/raghavam',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907455"',
      'faculty_Office_Address': 'B-404 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Knowledge Graphs/Semantic Web, Ontology modeling and reasoning, Linked Data, Big Data',
      'faculty_Teaching_Interests':
          'Semantic Web, Cloud Computing, Database Systems',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/raghavam',
      'faculty_Website_Page': '/raghavam',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fraghava.mutharaju%40iiitd.ac.in%2Fraghavam.png?alt=media&token=189eca9d-8207-4a69-904b-b2689e9b1e5b',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Venkata Ratnadeep Suri',
      'faculty_EmailId': 'ratan.suri@iiitd.ac.in',
      'faculty_Department': 'SSH',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Center for Design and New Media (Supported by Tata Consultancy Services, a TCS Foundation Initiative)',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Ratnadeep Suri (Ratan), Assistant Professor, SSH, IIIT-Delhi, has completed his Post Doctoral research at the Nanyang Technological University, Singapore in 2016. Earlier he earned his PhD from The Indiana Media School, Indiana University in 2013, with a Major in Communication and a Minor in Information Science. He also has an MA from Western Michigan University, Michigan, and an MA from University of Hyderabad, India. His research examines the effects of technology use in knowledge work contexts, health contexts, information seeking, and the cognition of information. He is also interested in the consequences of disrupted access to communication technologies on individuals in disadvantaged communities. Currently he is a Collaborating Investigator for a 100, 000 SG grant from Singapore Ministry of Education. He was the recipient of several awards including the the Indiana University, College of Arts and Sciences Dissertation Fellowship (2010-2011), The Indiana University Future Faculty Fellowship, to teach at Howard University, 2009-2010, The Graduate School Fellowship, Summer 2004, 2005, Indiana University, and The Kellogg Foundation Service Learning Scholarship in Summer 2002. In his free time Ratan pursues his interests in woodworking, traveling and photography.',
      'faculty_College': 'PhD (2013), Indiana University, Bloomington, Indiana',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/ratna-suri.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/venkata-ratnadeep-suri-6294a118a/',
      'faculty_Website_Url': 'https://iiitd.ac.in/ratan',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907445"',
      'faculty_Office_Address': '\nB-204 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'ICTs and Society, Information Literacy, Data Literacy, E-Health, M-health, Social media for Health, ICTs and Health behavior, ICTs and Development.',
      'faculty_Teaching_Interests': 'Social Sciences',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/ratan',
      'faculty_Website_Page': '/ratan',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fratan.suri%40iiitd.ac.in%2Fratan.png?alt=media&token=b4281104-874a-40bf-a055-998c6557ef26',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Vibhor Kumar',
      'faculty_EmailId': 'vibhor@iiitd.ac.in',
      'faculty_Department': 'CB',
      'faculty_Position': 'Associate Professo',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Ph.D. in Computational systems biology, Helsinki University of Technology (now Aalto), Finland. After completing his M. Tech. in computer technology from IIT Delhi, he started working with computational problems of analysing large image datasets from cryoEM and statistical analysis of Genomic data. During his Ph.D., he solved the first and highest resolution (so far) structure of LDL (bad cholesterol) in native state at human body temperature. After completing Ph.D., Dr Vibhor started applying computational approach to genomic data and worked for 1 year at a personal-genomics company in Malaysia. He has worked at Genome Institute of Singapore (GIS) for more than 8 years and has published some fundamental research findings. At GIS he was primarily working on epigenome and gene regulation and applied his findings to other branches such as cancer and stem cell study.Currently he is working in data sciences and Genomics.',
      'faculty_College':
          'Ph.D. from Helsinki University of Technology (now Aalto), Finland',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/vibhork.jpg',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': 'https://iiitd.ac.in/vibhork',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907440"',
      'faculty_Office_Address': '\nA-304 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Genomics, Computational Biology and Statistical Signal Processing',
      'faculty_Teaching_Interests':
          'Genomics, Computational Biology and Statistical Signal Processing',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/vibhork',
      'faculty_Website_Page': '/vibhork',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fvibhor%40iiitd.ac.in%2Fvibhork.png?alt=media&token=bab4ab90-4a14-4aa9-ba1e-a8d736d176e9',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Vikram Goyal',
      'faculty_EmailId': 'vikram@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'I am a faculty in IIIT-Delhi. I received my Ph.D. in Computer Science and Engineering from the Department of Computer Science and Engineering at IIT Delhi in 2009. Before pursuing Ph.D., I completed my M.Tech. in Information Systems from the Department of Computer Science and Engineering at NSIT Delhi in 2003. I have many publications in reputed conferences and referred journals. I have a couple of Projects from DST, India and Deity, India on problems related to Privacy in Location-based Services and Digitized Document Fraud Detection, respectively.',
      'faculty_College': 'PhD (2009), IIT Delhi, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/vikram.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/vikram-goyal-7a684213/',
      'faculty_Website_Url': 'https://iiitd.ac.in/vikram',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907474"',
      'faculty_Office_Address': '\nA-508 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Data Mining, Databases, Spatial Data Analytics',
      'faculty_Teaching_Interests':
          'Databases, Data Mining, Algorithms for Spatial Query Evaluation',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/vikram',
      'faculty_Website_Page': '/vikram',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fvikram%40iiitd.ac.in%2Fvikram.png?alt=media&token=921bc451-328f-41b4-a3b5-6d1886461602',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Vinayak Abrol',
      'faculty_EmailId': 'abrol@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': 'Cross-Caps',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Prior to this he held Oxford-Emirates data science fellowship at Mathematical Institute, University of Oxford (10/2018-12/2020), position of Academic Advisor at Kellogg college Oxford (7/2019-12/2020) and SNSF funded postdoctoral position at IDIAP research Institute, Switzerland (2/2018-10/2018). He received his TCS Innovation Labs funded Ph.D from School of Computing and Electrical engineering, IIT Mandi, India in 2018; following M.E and B.E in electronics and communication engineering from Panjab University Chandigarh, India in 2013 and 2011, respectively. His research focuses on the design, and analysis of numerical algorithms for information inspired applications, which is multi-disciplinary and lies at an intersection of Engineering, Maths and Computer Science. On the theoretical front he is currently working on developing theories of deep learning using tools from random matrix theory, and information theory, where as on the applied front his research interest is in area of speech/audio analytics on problem such as acoustic modelling and coding, voice biometrics, pathological speech and audio categorization. His research has been disseminated in several internationally reputed journals and conferences, including JASA, IEEE TASLP/TMM, Elsevier Speech Communication/CSL/PRL, ICML, NIPS, INTERSPEECH, and ICASSP. Network: Infosys Centre for AI',
      'faculty_College': 'PhD (2018), IIT Mandi, India',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/vabrol.jpg',
      'faculty_LinkedIn_Url': 'https://www.linkedin.com/in/vinayak-abrol/',
      'faculty_Website_Url': 'https://iiitd.ac.in/vabrol',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907543"',
      'faculty_Office_Address': 'B-409 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Acoustic modelling and coding ,Voice biometrics, Pathological speech and audio categorization',
      'faculty_Teaching_Interests':
          'Theories of Deep Learning, Machine Learning,Speech and Audio Processing',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/vabrol',
      'faculty_Website_Page': '/vabrol',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fabrol%40iiitd.ac.in%2Fvabrol.png?alt=media&token=2177255a-4c54-43e4-9c2f-57522044c45e',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Vivek Bohara',
      'faculty_EmailId': 'vivek.b@iiitd.ac.in',
      'faculty_Department': 'ECE',
      'faculty_Position': 'Head, Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs':
          'Centre of Excellence on Light Fidelity (LiFi),Wirocomm Research Group',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Dr. Vivek Ashok Bohara received the Ph.D. degree from Nanyang Technological University, Singapore, in 2011. From 2011 to 2013, he was a Postdoctoral Researcher (Marie Curie fellowship) in ESIEE Paris, University Paris-East where he was actively involved in designing and implementing critical blocks for wideband RF transmitters. Specifically, he proposed numerous green communication techniques to reduce power consumption and increase efficiency of nonlinear high power amplifiers used in RF transmitters.In 2013, he joined IIIT-Delhi, India, where he is currently Professor and Head, Department of Electronics and Communication Engineering. He has authored and coauthored over 100 publications in major IEEE/IET journals and refereed international conferences, two book chapters, and three patents. Dr. Bohara also supervises the Wirocomm Research Lab at IIIT Delhi which deals with state of the art research in wireless communication and allied area and is also the co-founding faculty member for Li-Fi Centre of excellence @ IIIT-Delhi. His research interests are next-generation communication technologies such as Visible Light Communication (VLC), hybrid RF-VLC communication, integration of optical communication with intelligent reflective surfaces (IRS), UAV, and vehicular communication.Dr. Bohara received First Prize in National Instruments ASEAN Virtual Instrumentation Applications Contest in 2007 and 2010. He was also the recipient of the Best Paper Award at the IEEE ANTS 2022 and the best poster and demo awards at IEEE Comsnets 2016 and 2023 conferences respectively.',
      'faculty_College':
          'Ph.D. (2011), Nanyang Technological University, Singapore',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/vivek_0.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/vivek-ashok-bohara-a496aa52/',
      'faculty_Website_Url': 'https://iiitd.ac.in/vivek',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '"011-26907454"',
      'faculty_Office_Address': 'A-609 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Visible Light Communication (Li-FI ),Cyber physical systems,Optical Intelligent Reflective surfaces,UAV and vehicular communication',
      'faculty_Teaching_Interests':
          'Wireless Communication,Digital Communication and Wireless System Implementation',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/vivek',
      'faculty_Website_Page': '/vivek',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fvivek.b%40iiitd.ac.in%2Fvivek.png?alt=media&token=112d17ee-a066-40ea-b63c-c658da33c89f',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Vivek Kumar',
      'faculty_EmailId': 'vivekk@iiitd.ac.in',
      'faculty_Department': 'CSE',
      'faculty_Position': 'Assistant Professor',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': 'True',
      'faculty_Bio':
          'Vivek Kumar works in the area of High Performance Computing. He received his Ph.D. from Australian National University and B.E. from Visvesvaraya Technological University. His Ph.D. research focused on using managed runtime techniques for improving the performance and productivity of parallel programming on multicore architectures. Prior to Ph.D., he has worked for nearly 6 years in research and development positions in HPC areas at technology firms such as CDAC R&D and IBM Systems and Technology Labs. After completing his Ph.D., he worked for nearly 3 years as a Research Scientist at Rice University.',
      'faculty_College':
          'PhD (2014), Research School of Computer Science, Australian National University',
      'faculty_Image_Url':
          'https://iiitd.ac.in/sites/default/files/images/faculty/vivekk.jpg',
      'faculty_LinkedIn_Url':
          'https://www.linkedin.com/in/vivek-kumar-42a4b121/',
      'faculty_Website_Url': 'https://iiitd.ac.in/vivekk',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '011-26907441',
      'faculty_Office_Address': 'B-506 (R&D Block)',
      'faculty_Office_Latitude': '28.5442185740552',
      'faculty_Office_Longitude': '77.2716830936104',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests':
          'Parallel programming models and runtime systems.',
      'faculty_Teaching_Interests':
          'Parallel programming models and runtime systems.',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/vivekk',
      'faculty_Website_Page': '/vivekk',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2Fvivekk%40iiitd.ac.in%2Fvivekk.png?alt=media&token=5d072cce-4362-4ae3-8035-66e5473821ae',
      'faculty_Type': ''
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Aman Samuel',
      'faculty_EmailId': 'aman.samuel@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/Aman',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Faman.samuel%40iiitd.ac.in%2Faman-samule.jpg?alt=media&token=70444245-9009-4140-bdbe-2c8f73aa61c4',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Amrit Srinivasan',
      'faculty_EmailId': 'amrit@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/AmritSrinivasan',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Famrit%40iiitd.ac.in%2FAmritSrinivasan.png?alt=media&token=52371f09-a741-4537-ac49-cd77304a36b9',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Anoop Ratn',
      'faculty_EmailId': 'anoopratn@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/AnoopRatn',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fanoopratn%40iiitd.ac.in%2FAnoopRatn%20(1).png?alt=media&token=cd7c5594-6a7b-4237-8f0b-0ad23a162e95',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Bijendra Nath Jain',
      'faculty_EmailId': 'bnjain@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/BijendraNathJain',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fbnjain%40iiitd.ac.in%2FBijendra%20Nath%20Jain.png?alt=media&token=569daaca-7276-477f-81dc-e7f606f90721',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'C. Anantaram',
      'faculty_EmailId': 'c.anantaram@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/CAnantaram',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fc.anantaram%40iiitd.ac.in%2F_CAnantaram.png?alt=media&token=74e5e8e1-9bd6-4b06-919b-ae713b3566a5',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'D. K. Sharma',
      'faculty_EmailId': 'sharmadk@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/DKSharma',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fsharmadk%40iiitd.ac.in%2FDKSharma%20(1).png?alt=media&token=a03933b1-0df4-4ac8-a94a-8d5373868ff3',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Krishanu Roy',
      'faculty_EmailId': 'krishanu@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/KrishanuRoy',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fkrishanu%40iiitd.ac.in%2FKrishanuRoy%20(1).png?alt=media&token=78ce9e36-f2cf-4f4d-a9c1-eb0d3ceab6c3',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Payel C Mukherjee',
      'faculty_EmailId': 'payel@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/PayelCMukherjee',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fpayel%40iiitd.ac.in%2FPayelCMukherjee%20(1).png?alt=media&token=395dd798-b8f4-4628-833b-be67b560f0e1',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Samaresh Chatterji',
      'faculty_EmailId': 'samaresh@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/SamareshChatterji',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fsamaresh%40iiitd.ac.in%2FSamareshChatterji%20(1).png?alt=media&token=71ca61eb-cffd-451c-88bd-c7f01311ce66',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Subhajit Ghosechowdhury',
      'faculty_EmailId': 'subhajit@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links':
          'https://iiitdriise.page.link/SubhajitGhosechowdhury',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fsubhajit%40iiitd.ac.in%2FSubhajitGhosechowdhury.png?alt=media&token=cca0f3d0-9f90-453b-960c-38b9ba42499a',
      'faculty_Type': 'Visiting Faculty'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Angshu Das',
      'faculty_EmailId': 'angshu.das@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/AngshuDas',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fangshu.das%40iiitd.ac.in%2FAngshu%20Das.png?alt=media&token=a589265d-7dcc-4213-b40f-149e39d4cd06',
      'faculty_Type': 'Professor of Practice'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Dhurjati Majumdar',
      'faculty_EmailId': 'dhurjati@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/DhurjatiMajumdar',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fdhurjati%40iiitd.ac.in%2FDhurjatiMajumdar%20(1).png?alt=media&token=b5a46835-7850-40ef-b2ec-11f60d7f372e',
      'faculty_Type': 'Professor of Practice'
    },
    {
      'faculty_Unique_Id': '',
      'faculty_Name': 'Pankaj Vajpayee',
      'faculty_EmailId': 'pvajpayee@iiitd.ac.in',
      'faculty_Department': '',
      'faculty_Position': '',
      'faculty_Gender': '',
      'faculty_Affiliated_Centers_And_Labs': '',
      'faculty_Authorization': '',
      'faculty_Bio': '',
      'faculty_College': '',
      'faculty_Image_Url': '',
      'faculty_LinkedIn_Url': '',
      'faculty_Website_Url': '',
      'faculty_Mobile_Messaging_Token_Id': '',
      'faculty_Mobile_Number': '',
      'faculty_Office_Address': '',
      'faculty_Office_Latitude': '',
      'faculty_Office_Longitude': '',
      'faculty_Office_Navigation_Url': '',
      'faculty_Research_Interests': '',
      'faculty_Teaching_Interests': '',
      'faculty_Dynamic_Links': 'https://iiitdriise.page.link/PankajVajpayee',
      'faculty_Website_Page': '/people/visiting-faculty',
      'faculty_QR_Code_Image_Url':
          'https://firebasestorage.googleapis.com/v0/b/riise-application.appspot.com/o/FacultyQRCodeImages%2FVisiting%20and%20POP%2Fpvajpayee%40iiitd.ac.in%2FPankajVajpayee%20(1).png?alt=media&token=de06441c-49c6-4098-9e6e-ade85cd8386f',
      'faculty_Type': 'Professor of Practice'
    }
  ];

  List<FacultyServerInformation> facultiesList = [
    // FacultyServerInformation(
    //   faculty_Unique_Id: "1",
    //   faculty_Name: "Henansh",
    //   faculty_Position: "CEO",
    //   faculty_EmailId: "temp@gmail.com",
    //   faculty_Gender: "Male",
    //   faculty_Bio: "BIO",
    //   faculty_Image_Url: "assets/images/icons/profile.png",
    //   faculty_LinkedIn_Url: "assets/images/icons/profile.png",
    //   faculty_Website_Url: "assets/images/icons/profile.png",
    //   faculty_Office_Address: "addr",
    //   faculty_Office_Latitude: 12.5,
    //   faculty_Office_Longitude: 10.2,
    //   faculty_Mobile_Messaging_Token_Id: 'dsafasdfsa',
    //   faculty_Affiliated_Centers_And_Labs:
    //       'fasdf, dsfasd, fsdfsdf, dasfasd, fadsfsad',
    //   faculty_College: 'IIIT Delhi',
    //   faculty_Mobile_Number: '123456789',
    //   faculty_Research_Interests: 'd d d d d d',
    // ),
  ];

  Future<FacultyServerInformation> getFacultyDetails(
    String facultyDatabaseUniqueId,
  ) async {
    late FacultyServerInformation facultyInfo;

    await FirebaseFirestore.instance
        .collection('FacultiesInformationList')
        // .doc(facultyDatabaseUniqueId)
        .doc(qrIdentifierMap[facultyDatabaseUniqueId])
        .get()
        .then((DocumentSnapshot ds) {
      facultyInfo = new FacultyServerInformation(
        faculty_Unique_Id: ds.get('faculty_Unique_Id').toString(),
        faculty_Authorization: ds.get('faculty_Authorization').toString() == 'true',
        faculty_Mobile_Messaging_Token_Id: ds.get('faculty_Mobile_Messaging_Token_Id').toString(),
        faculty_Name: ds.get('faculty_Name').toString(),
        faculty_Position: ds.get('faculty_Position').toString(),
        faculty_College: ds.get('faculty_College').toString(),
        faculty_Department: ds.get('faculty_Department').toString(),
        faculty_Mobile_Number: ds.get('faculty_Mobile_Number').toString(),
        faculty_Teaching_Interests: ds.get('faculty_Teaching_Interests').toString(),
        faculty_Research_Interests: ds.get('faculty_Research_Interests').toString(),
        faculty_Affiliated_Centers_And_Labs: ds.get('faculty_Affiliated_Centers_And_Labs').toString(),
        faculty_EmailId: ds.get('faculty_EmailId').toString(),
        faculty_Gender: ds.get('faculty_Gender').toString(),
        faculty_Bio: ds.get('faculty_Bio').toString(),
        faculty_Image_Url: ds.get('faculty_Image_Url').toString(),
        faculty_LinkedIn_Url: ds.get('faculty_LinkedIn_Url').toString(),
        faculty_Website_Url: ds.get('faculty_Website_Url').toString(),
        faculty_Office_Navigation_Url: ds.get('faculty_Office_Navigation_Url').toString(),
        faculty_Office_Address: ds.get('faculty_Office_Address').toString(),
        faculty_Office_Longitude: checkIfDouble(ds.get('faculty_Office_Longitude').toString()),
        faculty_Office_Latitude: checkIfDouble(ds.get('faculty_Office_Latitude').toString()),
      );
    });

    notifyListeners();
    return facultyInfo;
  }

  Future<void> facultyQRCodeNavigator(
    BuildContext context,
    String facultyDatabaseUniqueId,
  ) async {
    late FacultyServerInformation facultyInfo;

    await FirebaseFirestore.instance
        .collection('FacultiesInformationList')
        // .doc(facultyDatabaseUniqueId)
        .doc(qrIdentifierMap[facultyDatabaseUniqueId])
        .get()
        .then((DocumentSnapshot ds) {
      facultyInfo = new FacultyServerInformation(
        faculty_Unique_Id: ds.get('faculty_Unique_Id').toString(),
        faculty_Authorization:
            ds.get('faculty_Authorization').toString() == 'true',
        faculty_Mobile_Messaging_Token_Id:
            ds.get('faculty_Mobile_Messaging_Token_Id').toString(),
        faculty_Name: ds.get('faculty_Name').toString(),
        faculty_Position: ds.get('faculty_Position').toString(),
        faculty_College: ds.get('faculty_College').toString(),
        faculty_Department: ds.get('faculty_Department').toString(),
        faculty_Mobile_Number: ds.get('faculty_Mobile_Number').toString(),
        faculty_Teaching_Interests:
            ds.get('faculty_Teaching_Interests').toString(),
        faculty_Research_Interests:
            ds.get('faculty_Research_Interests').toString(),
        faculty_Affiliated_Centers_And_Labs:
            ds.get('faculty_Affiliated_Centers_And_Labs').toString(),
        faculty_EmailId: ds.get('faculty_EmailId').toString(),
        faculty_Gender: ds.get('faculty_Gender').toString(),
        faculty_Bio: ds.get('faculty_Bio').toString(),
        faculty_Image_Url: ds.get('faculty_Image_Url').toString(),
        faculty_LinkedIn_Url: ds.get('faculty_LinkedIn_Url').toString(),
        faculty_Website_Url: ds.get('faculty_Website_Url').toString(),
        faculty_Office_Navigation_Url:
            ds.get('faculty_Office_Navigation_Url').toString(),
        faculty_Office_Address: ds.get('faculty_Office_Address').toString(),
        faculty_Office_Longitude:
            checkIfDouble(ds.get('faculty_Office_Longitude').toString()),
        faculty_Office_Latitude:
            checkIfDouble(ds.get('faculty_Office_Latitude').toString()),
      );
    });

    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => FacultyDetailScreen(
    //       facultyDetails: facultyInfo,
    //     ),
    //   ),
    //   (route) => false,
    // );
  }

  Map<String, String> qrIdentifierMap = {
    "/subramanyam": "subramanyam@iiitd.ac.in",
    "/aasim": "aasim@iiitd.ac.in",
    "/abhijit": "abhijit@iiitd.ac.in",
    "/aman": "aman@iiitd.ac.in",
    "/anand": "anand@iiitd.ac.in",
    "/angshul": "angshul@iiitd.ac.in",
    "/anmol": "anmol@iiitd.ac.in",
    "/anubha": "anubha@iiitd.ac.in",
    "/anujg": "anuj@iiitd.ac.in",
    "/anuradha": "anuradha@iiitd.ac.in",
    "/arani": "arani@iiitd.ac.in",
    "/arjun": "arjun@iiitd.ac.in",
    "/arunb": "arunb@iiitd.ac.in",
    "/ashishk": "ashish.pandey@iiitd.ac.in",
    "/bapi": "bapi@iiitd.ac.in",
    "/chanekar": "prasad@iiitd.ac.in",
    "/dbera": "dbera@iiitd.ac.in",
    "/debarka": "debarka@iiitd.ac.in",
    "/debika": "debika@iiitd.ac.in",
    "/dhruv": "dhruv.kumar@iiitd.ac.in",
    "/diptapriyo": "diptapriyo@iiitd.ac.in",
    "/donghoon": "donghoon@iiitd.ac.in",
    "/raghava": "raghava@iiitd.ac.in",
    "/bagler": "bagler@iiitd.ac.in",
    "/gauravahuja": "gaurav.ahuja@iiitd.ac.in",
    "/gaurava": "gaurav@iiitd.ac.in",
    "/gayatri": "gayatri@iiitd.ac.in",
    "/jainendra": "jainendra@iiitd.ac.in",
    "/jaspreet": "jaspreet@iiitd.ac.in",
    "/kaushik": "kaushik@iiitd.ac.in",
    "/kanjilal": "kanjilal@iiitd.ac.in",
    "/koteswar": "koteswar@iiitd.ac.in",
    "/manohark": "manohar.kumar@iiitd.ac.in",
    "/manuj": "manuj@iiitd.ac.in",
    "/shad": "shad.akhtar@iiitd.ac.in",
    "/monika": "monika@iiitd.ac.in",
    "/mrinmoy": "mrinmoy@iiitd.ac.in",
    "/mukesh": "mukesh@iiitd.ac.in",
    "/mukulika": "mukulika@iiitd.ac.in",
    "/arulmurugan": "arul.murugan@iiitd.ac.in.",
    "/nishad": "nishad@iiitd.ac.in",
    "/ojaswa": "ojaswa@iiitd.ac.in",
    "/jalote": "jalote@iiitd.ac.in",
    "/paro": "paro.mishra@iiitd.ac.in",
    "/piyus": "piyus@iiitd.ac.in",
    "/praveen": "praveen@iiitd.ac.in",
    "/praveshb": "praveshb@iiitd.ac.in",
    "/pushpendra": "psingh@iiitd.ac.in",
    "/rajiv": "rajiv@iiitd.ac.in",
    "/rajivratn": "rajivratn@iiitd.ac.in",
    "/rakesh": "rakesh@iiitd.ac.in",
    "/rkghosh": "rkghosh@iiitd.ac.in",
    "/bose": "bose@iiitd.ac.in",
    "/ranjitha": "ranjitha@iiitd.ac.in",
    "/richagupta": "richa.gupta@iiitd.ac.in",
    "/rinku": "rinku@iiitd.ac.in",
    "/anands": "anands@iiitd.ac.in",
    "/sambuddho": "sambuddho@iiitd.ac.in",
    "/samrithram": "samrith@iiitd.ac.in",
    "/sanat": "sanat@iiitd.ac.in",
    "/skkaul": "skkaul@iiitd.ac.in",
    "/sankha": "sankha@iiitd.ac.in",
    "/sarthok": "sarthok@iiitd.ac.in",
    "/satish": "satish@iiitd.ac.in",
    "/sayak": "sayak@iiitd.ac.in",
    "/sayan": "sayan@iiitd.ac.in",
    "/shobha": "shobha@iiitd.ac.in",
    "/smriti": "smriti@iiitd.ac.in",
    "/sneh": "sneh@iiitd.ac.in",
    "/sneha": "sneha@iiitd.ac.in",
    "/sonia": "sonia@iiitd.ac.in",
    "/souvik": "souvik@iiitd.ac.in",
    "/sriram": "sriramk@iiitd.ac.in",
    "/subhabrata": "subhabrata@iiitd.ac.in",
    "/subhashreem": "subhashree@iiitd.ac.in",
    "/sdeb": "sdeb@iiitd.ac.in",
    "/sumit": "sumit@iiitd.ac.in",
    "/syamantak": "syamantak@iiitd.ac.in",
    "/tammam": "tammam@iiitd.ac.in",
    "/tanmoy": "tanmoy@iiitd.ac.in",
    "/tarini": "tarini.ghosh@iiitd.ac.in",
    "/tavpritesh": "tavpriteshsethi@iiitd.ac.in",
    "/raghavam": "raghava.mutharaju@iiitd.ac.in",
    "/ratan": "ratan.suri@iiitd.ac.in",
    "/vibhork": "vibhor@iiitd.ac.in",
    "/vikram": "vikram@iiitd.ac.in",
    "/vabrol": "abrol@iiitd.ac.in",
    "/vivek": "vivek.b@iiitd.ac.in",
    "/vivekk": "vivekk@iiitd.ac.in",
  };

  Future<void> fetchCollegeFaculties(
    BuildContext context,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference facultiesRef =
        db.collection("FacultiesInformationList");

    List<FacultyServerInformation> listOfFaculties = [];
    try {
      await facultiesRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (facultyDetails) async {
              final facultyMap = facultyDetails.data() as Map<String, dynamic>;

              if (facultyMap['faculty_Authorization']
                      .toString()
                      .toLowerCase() ==
                  'true') {
                FacultyServerInformation facultyInfo = FacultyServerInformation(
                  faculty_Unique_Id: facultyMap["faculty_Unique_Id"],
                  faculty_Name: facultyMap["faculty_Name"],
                  faculty_EmailId: facultyMap["faculty_EmailId"],
                  faculty_Position: facultyMap["faculty_Position"],
                  faculty_Gender: facultyMap["faculty_Gender"],
                  faculty_Bio: facultyMap["faculty_Bio"],
                  faculty_Teaching_Interests:
                      facultyMap["faculty_Teaching_Interests"],
                  faculty_Authorization:
                      facultyMap["faculty_Authorization"] == "true",
                  faculty_Image_Url: facultyMap["faculty_Image_Url"],
                  faculty_LinkedIn_Url: facultyMap["faculty_LinkedIn_Url"],
                  faculty_Website_Url: facultyMap["faculty_Website_Url"],
                  faculty_Office_Navigation_Url:
                      facultyMap["faculty_Office_Navigation_Url"],
                  faculty_Office_Address: facultyMap["faculty_Office_Address"],
                  faculty_Office_Longitude:
                      checkIfDouble(facultyMap["faculty_Office_Longitude"]),
                  faculty_Office_Latitude:
                      checkIfDouble(facultyMap["faculty_Office_Latitude"]),
                  faculty_Mobile_Messaging_Token_Id:
                      facultyMap['faculty_Mobile_Messaging_Token_Id'],
                  faculty_Affiliated_Centers_And_Labs:
                      facultyMap['faculty_Affiliated_Centers_And_Labs'],
                  faculty_College: facultyMap['faculty_College'],
                  faculty_Mobile_Number: facultyMap['faculty_Mobile_Number'],
                  faculty_Research_Interests:
                      facultyMap['faculty_Research_Interests'],
                  faculty_Department: facultyMap['faculty_Department'],
                );

                listOfFaculties.add(facultyInfo);
              }
            },
          );
        },
      );

      facultiesList = listOfFaculties;
      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }

    // return listOfFaculties;
  }

  Future<List<FacultyServerInformation>> fetchFacultyList(
    BuildContext context,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference facultiesRef =
        db.collection("FacultiesInformationList");

    List<FacultyServerInformation> listOfFaculties = [];
    try {
      await facultiesRef.get().then(
        (ds) async {
          ds.docs.forEach(
            (facultyDetails) async {
              final facultyMap = facultyDetails.data() as Map<String, dynamic>;

              if (facultyMap['faculty_Authorization']
                      .toString()
                      .toLowerCase() ==
                  'true') {
                FacultyServerInformation facultyInfo = FacultyServerInformation(
                  faculty_Unique_Id: facultyMap["faculty_Unique_Id"],
                  faculty_Name: facultyMap["faculty_Name"],
                  faculty_EmailId: facultyMap["faculty_EmailId"],
                  faculty_Position: facultyMap["faculty_Position"],
                  faculty_Gender: facultyMap["faculty_Gender"],
                  faculty_Bio: facultyMap["faculty_Bio"],
                  faculty_Teaching_Interests:
                      facultyMap["faculty_Teaching_Interests"],
                  faculty_Authorization:
                      facultyMap["faculty_Authorization"] == "true",
                  faculty_Image_Url: facultyMap["faculty_Image_Url"],
                  faculty_LinkedIn_Url: facultyMap["faculty_LinkedIn_Url"],
                  faculty_Website_Url: facultyMap["faculty_Website_Url"],
                  faculty_Office_Navigation_Url:
                      facultyMap["faculty_Office_Navigation_Url"],
                  faculty_Office_Address: facultyMap["faculty_Office_Address"],
                  faculty_Office_Longitude:
                      checkIfDouble(facultyMap["faculty_Office_Longitude"]),
                  faculty_Office_Latitude:
                      checkIfDouble(facultyMap["faculty_Office_Latitude"]),
                  faculty_Mobile_Messaging_Token_Id:
                      facultyMap['faculty_Mobile_Messaging_Token_Id'],
                  faculty_Affiliated_Centers_And_Labs:
                      facultyMap['faculty_Affiliated_Centers_And_Labs'],
                  faculty_College: facultyMap['faculty_College'],
                  faculty_Mobile_Number: facultyMap['faculty_Mobile_Number'],
                  faculty_Research_Interests:
                      facultyMap['faculty_Research_Interests'],
                  faculty_Department: facultyMap['faculty_Department'],
                );

                listOfFaculties.add(facultyInfo);
              }
            },
          );
        },
      );
      notifyListeners();
    } catch (errorVal) {
      print(errorVal);
    }

    return listOfFaculties;
  }

  Map<String, String> qrMapping = {};

  Future<void> insertListOfFaculties(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("FacultiesInformationList");

    String value = "";

    try {
      dataList.forEach((element) async {
        qrMapping[element['faculty_Website_Page'].toString()] = element['faculty_EmailId'].toString();
        value = '"${element['faculty_Website_Page'].toString()}": "${element['faculty_EmailId'].toString()}"';
        print(value);

        await usersRef.doc(element['faculty_EmailId']).set(
          {
            "faculty_Unique_Id": "",
            "faculty_Name": element['faculty_Name'],
            "faculty_EmailId": element['faculty_EmailId'],
            "faculty_Department": element['faculty_Department'],
            "faculty_Position": element['faculty_Position'],
            "faculty_Gender": "",
            "faculty_Affiliated_Centers_And_Labs": element['faculty_Affiliated_Centers_And_Labs'],
            "faculty_Authorization": "true",
            "faculty_Bio": element['faculty_Bio'],
            "faculty_College": element['faculty_College'],
            "faculty_Image_Url": element['faculty_Image_Url'],
            "faculty_LinkedIn_Url": element['faculty_LinkedIn_Url'],
            "faculty_Mobile_Messaging_Token_Id": "",
            "faculty_Mobile_Number": element['faculty_Mobile_Number'],
            "faculty_Office_Address": element['faculty_Office_Address'],
            "faculty_Office_Latitude": element['faculty_Office_Latitude'],
            "faculty_Office_Longitude": element['faculty_Office_Longitude'],
            "faculty_Office_Navigation_Url": "",
            "faculty_Research_Interests": element['faculty_Research_Interests'],
            "faculty_Teaching_Interests": element['faculty_Teaching_Interests'],
            "faculty_Dynamic_Links": element['faculty_Dynamic_Links'],
            "faculty_Website_Page": element['faculty_Website_Page'],
            "faculty_QR_Code_Image_Url": element['faculty_QR_Code_Image_Url'],
            "faculty_Website_Url": element['faculty_Website_Url'],
            "faculty_Type": element['faculty_Type'],
            "faculty_Google_Auth_Token_Id": "",
          },
        );
      });
    } catch (errorVal) {
      print(errorVal);
    }
  }

  double checkIfDouble(String val) {
    if (double.tryParse(val).toString() != 'null') {
      return double.parse(val);
    } else if (val == 'null' ||
        val == '' ||
        int.tryParse(val).toString() == 'null' ||
        double.tryParse(val).toString() == 'null') {
      return 0.0;
    } else {
      return double.parse(val);
    }
  }
}