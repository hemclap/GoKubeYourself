import axios from "axios";

const API_URL = "http://localhost:8080/api/test/cluster/";

class ClusterService {
	createCluster(
		serverAddress: string,
		serverLogin: string,
		rootPassword: string
	) {
		return axios
			.post(API_URL, {
				serverAddress,
				serverLogin,
				rootPassword,
			})
			.then((response) => {
				return response.data;
			});
	}

	getAllClusters(userId: string) {
		return axios.get(API_URL + userId).then((response) => {
			return response.data;
		});
	}
}

export default new ClusterService();
